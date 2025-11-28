# MCP Debugger Tool - Design

## Architecture

```
┌─────────────────┐
│   AI Agent      │
│   (Kiro)        │
└────────┬────────┘
         │ MCP Protocol
         │
┌────────▼────────┐
│  MCP Debugger   │
│     Server      │
└────────┬────────┘
         │ Inspector Protocol (CDP)
         │
┌────────▼────────┐
│   Node.js       │
│   Process       │
│  (Test Runner)  │
└─────────────────┘
```

## Core Components

### 1. MCP Server
- Implements MCP protocol
- Exposes debugging tools
- Manages debug sessions
- Handles tool calls from AI agent

### 2. Inspector Client
- Connects to Node.js Inspector
- Sends CDP commands
- Receives CDP events
- Manages WebSocket connection

### 3. Session Manager
- Tracks active debug sessions
- Maps session IDs to processes
- Handles session lifecycle
- Cleans up resources

### 4. Breakpoint Manager
- Stores breakpoint definitions
- Resolves file paths to script IDs
- Handles source maps
- Manages breakpoint state

### 5. Hang Detector
- Monitors process execution
- Detects infinite loops
- Samples call stack periodically
- Reports hang location

## Implementation Details

### Starting a Debug Session

```typescript
// 1. Spawn process with inspector enabled
const child = spawn('node', [
  '--inspect-brk=0',  // Random port, break on start
  '--enable-source-maps',
  testFile
], {
  stdio: ['pipe', 'pipe', 'pipe'],
  env: { ...process.env, NODE_OPTIONS: '--enable-source-maps' }
});

// 2. Parse inspector URL from stderr
child.stderr.on('data', (data) => {
  const match = data.toString().match(/ws:\/\/127\.0\.0\.1:(\d+)\//);
  if (match) {
    const wsUrl = match[0];
    connectToInspector(wsUrl);
  }
});

// 3. Connect via WebSocket
const ws = new WebSocket(wsUrl);
ws.on('open', () => {
  // Send CDP commands
  sendCommand('Debugger.enable');
  sendCommand('Runtime.enable');
});
```

### Setting Breakpoints

```typescript
async function setBreakpoint(file: string, line: number) {
  // 1. Resolve file to script ID
  const scripts = await sendCommand('Debugger.getScriptSource');
  const script = scripts.find(s => s.url.endsWith(file));
  
  // 2. Set breakpoint
  const result = await sendCommand('Debugger.setBreakpointByUrl', {
    lineNumber: line - 1,  // 0-indexed
    url: script.url,
    columnNumber: 0
  });
  
  return result.breakpointId;
}
```

### Inspecting Variables

```typescript
async function inspectVariable(expression: string) {
  // 1. Get current call frame
  const { callFrames } = await sendCommand('Debugger.getStackTrace');
  const topFrame = callFrames[0];
  
  // 2. Evaluate expression in frame context
  const result = await sendCommand('Debugger.evaluateOnCallFrame', {
    callFrameId: topFrame.callFrameId,
    expression: expression,
    returnByValue: true
  });
  
  return result.result.value;
}
```

### Detecting Hangs

```typescript
async function detectHang(command: string, timeout: number) {
  const session = await startDebugSession(command);
  
  // Sample call stack every 100ms
  const samples: string[] = [];
  const interval = setInterval(async () => {
    const stack = await getCallStack(session.id);
    const location = `${stack[0].file}:${stack[0].line}`;
    samples.push(location);
    
    // If same location for 50 samples (5 seconds), it's hung
    if (samples.length > 50) {
      const recent = samples.slice(-50);
      if (recent.every(s => s === recent[0])) {
        clearInterval(interval);
        return {
          hung: true,
          location: recent[0],
          stack: stack
        };
      }
    }
  }, 100);
  
  // Wait for completion or timeout
  await Promise.race([
    session.completion,
    sleep(timeout)
  ]);
  
  clearInterval(interval);
}
```

## MCP Tool Implementations

### Tool: debugger_start

```typescript
{
  name: 'debugger_start',
  async handler(args) {
    const { command, args: cmdArgs, cwd, timeout } = args;
    
    // Start process with inspector
    const session = await startDebugSession({
      command,
      args: cmdArgs,
      cwd,
      timeout
    });
    
    return {
      sessionId: session.id,
      inspectorUrl: session.wsUrl,
      pid: session.process.pid,
      status: 'paused'  // Paused at start
    };
  }
}
```

### Tool: debugger_set_breakpoint

```typescript
{
  name: 'debugger_set_breakpoint',
  async handler(args) {
    const { file, line, condition } = args;
    
    // Resolve file path
    const absolutePath = path.resolve(file);
    
    // Set breakpoint via CDP
    const breakpointId = await setBreakpoint(absolutePath, line, condition);
    
    return {
      breakpointId,
      file: absolutePath,
      line,
      verified: true
    };
  }
}
```

### Tool: debugger_inspect

```typescript
{
  name: 'debugger_inspect',
  async handler(args) {
    const { sessionId, expression } = args;
    
    const session = getSession(sessionId);
    if (!session.paused) {
      throw new Error('Process must be paused to inspect variables');
    }
    
    const value = await inspectVariable(session, expression);
    
    return {
      expression,
      value,
      type: typeof value
    };
  }
}
```

### Tool: debugger_detect_hang

```typescript
{
  name: 'debugger_detect_hang',
  async handler(args) {
    const { command, args: cmdArgs, timeout, sampleInterval = 100 } = args;
    
    const result = await detectHang(command, cmdArgs, timeout, sampleInterval);
    
    if (result.hung) {
      return {
        hung: true,
        location: result.location,
        stack: result.stack.map(frame => ({
          function: frame.functionName,
          file: frame.url,
          line: frame.lineNumber
        })),
        message: `Process hung at ${result.location}`
      };
    }
    
    return {
      hung: false,
      completed: true,
      exitCode: result.exitCode
    };
  }
}
```

## Source Map Support

```typescript
// Load source maps
import { SourceMapConsumer } from 'source-map';

async function resolveSourceLocation(file: string, line: number) {
  // Check if file is compiled (has .map file)
  const mapFile = `${file}.map`;
  if (!fs.existsSync(mapFile)) {
    return { file, line };
  }
  
  // Load source map
  const mapContent = fs.readFileSync(mapFile, 'utf8');
  const consumer = await new SourceMapConsumer(mapContent);
  
  // Map compiled location to source location
  const original = consumer.originalPositionFor({
    line,
    column: 0
  });
  
  return {
    file: original.source,
    line: original.line
  };
}
```

## Error Handling

```typescript
class DebuggerError extends Error {
  constructor(
    message: string,
    public code: string,
    public details?: any
  ) {
    super(message);
    this.name = 'DebuggerError';
  }
}

// Handle CDP errors
try {
  await sendCommand('Debugger.setBreakpoint', params);
} catch (error) {
  if (error.code === 'BREAKPOINT_NOT_RESOLVED') {
    throw new DebuggerError(
      'Could not set breakpoint - file not loaded yet',
      'BREAKPOINT_PENDING',
      { file, line }
    );
  }
  throw error;
}
```

## Session Lifecycle

```typescript
class DebugSession {
  id: string;
  process: ChildProcess;
  inspector: InspectorClient;
  breakpoints: Map<string, Breakpoint>;
  paused: boolean = false;
  
  async start() {
    // Spawn process
    this.process = spawnWithInspector(this.command);
    
    // Connect inspector
    this.inspector = await connectInspector(this.process);
    
    // Enable debugging
    await this.inspector.send('Debugger.enable');
    await this.inspector.send('Runtime.enable');
    
    // Set up event handlers
    this.inspector.on('Debugger.paused', () => {
      this.paused = true;
    });
    
    this.inspector.on('Debugger.resumed', () => {
      this.paused = false;
    });
  }
  
  async cleanup() {
    // Remove all breakpoints
    for (const bp of this.breakpoints.values()) {
      await this.inspector.send('Debugger.removeBreakpoint', {
        breakpointId: bp.id
      });
    }
    
    // Disconnect inspector
    await this.inspector.disconnect();
    
    // Kill process if still running
    if (!this.process.killed) {
      this.process.kill();
    }
  }
}
```

## Testing Strategy

### Unit Tests
- Test CDP command formatting
- Test source map resolution
- Test breakpoint management
- Test session lifecycle

### Integration Tests
- Test with simple Node.js script
- Test with TypeScript file
- Test with Jest test
- Test hang detection

### Example Test Cases

```typescript
describe('MCP Debugger', () => {
  it('should set breakpoint and pause execution', async () => {
    const session = await debugger.start({
      command: 'node',
      args: ['test-script.js']
    });
    
    await debugger.setBreakpoint({
      file: 'test-script.js',
      line: 5
    });
    
    await debugger.continue({ sessionId: session.id });
    
    // Should pause at breakpoint
    expect(session.paused).toBe(true);
    expect(session.currentLine).toBe(5);
  });
  
  it('should detect hanging loop', async () => {
    const result = await debugger.detectHang({
      command: 'node',
      args: ['infinite-loop.js'],
      timeout: 5000
    });
    
    expect(result.hung).toBe(true);
    expect(result.location).toContain('infinite-loop.js');
  });
});
```

## Performance Considerations

1. **Minimize CDP Calls**: Batch commands when possible
2. **Efficient Serialization**: Limit object depth when inspecting
3. **Smart Sampling**: Adjust hang detection interval based on timeout
4. **Resource Cleanup**: Always clean up sessions to prevent leaks

## Security Considerations

1. **Local Only**: Only allow debugging local processes
2. **No Remote Access**: Don't expose inspector port externally
3. **Validate Paths**: Sanitize file paths to prevent directory traversal
4. **Timeout Limits**: Enforce maximum timeout to prevent resource exhaustion

## Future Enhancements

1. **Conditional Breakpoints**: Support complex conditions
2. **Watch Expressions**: Monitor variable changes
3. **Log Points**: Log without stopping
4. **Time Travel**: Record and replay execution
5. **Smart Suggestions**: AI-powered debugging hints
