# MCP Debugger Tool - Implementation Tasks

## MVP Scope (Phase 1)

Focus on **hang detection** and **basic inspection** - the features needed to debug the audit tests.

**Target**: 8-10 hours for working MVP

## Phase 1: MVP Implementation (8-10 hours)

### Task 1.1: Project Setup
**Time**: 30 minutes
**Priority**: HIGH

**Steps:**
1. [ ] Create project structure
   ```
   tools/mcp-debugger/
   ├── package.json
   ├── tsconfig.json
   ├── src/
   │   ├── index.ts          # MCP server entry point
   │   ├── inspector.ts      # Inspector client
   │   ├── session.ts        # Session manager
   │   └── tools/            # MCP tool implementations
   │       ├── detect-hang.ts
   │       ├── start.ts
   │       └── inspect.ts
   └── tests/
       └── fixtures/
   ```

2. [ ] Initialize package.json
   ```json
   {
     "name": "@express-suite/mcp-debugger",
     "version": "0.1.0",
     "type": "module",
     "dependencies": {
       "@modelcontextprotocol/sdk": "latest",
       "ws": "^8.0.0"
     }
   }
   ```

3. [ ] Install dependencies
4. [ ] Set up TypeScript configuration

**Acceptance Criteria:**
- Project structure created
- Dependencies installed
- TypeScript compiles

---

### Task 1.2: Inspector Client (Core)
**Time**: 2 hours
**Priority**: HIGH

**Steps:**
1. [ ] Create `InspectorClient` class
   ```typescript
   class InspectorClient {
     private ws: WebSocket;
     private messageId = 0;
     private pending = new Map();
     
     async connect(wsUrl: string): Promise<void>
     async send(method: string, params?: any): Promise<any>
     on(event: string, handler: Function): void
     async disconnect(): Promise<void>
   }
   ```

2. [ ] Implement WebSocket connection
3. [ ] Implement CDP message protocol
4. [ ] Handle CDP events
5. [ ] Add error handling
6. [ ] Add timeout handling

**Acceptance Criteria:**
- Can connect to Node.js inspector
- Can send CDP commands
- Can receive CDP responses
- Handles errors gracefully

---

### Task 1.3: Process Spawner
**Time**: 1 hour
**Priority**: HIGH

**Steps:**
1. [ ] Create `spawnWithInspector` function
   ```typescript
   async function spawnWithInspector(
     command: string,
     args: string[],
     options: SpawnOptions
   ): Promise<{
     process: ChildProcess;
     inspectorUrl: string;
   }>
   ```

2. [ ] Spawn process with `--inspect-brk=0`
3. [ ] Parse inspector URL from stderr
4. [ ] Handle spawn errors
5. [ ] Add timeout for inspector URL detection

**Acceptance Criteria:**
- Can spawn Node.js process with inspector
- Extracts inspector WebSocket URL
- Handles errors properly

---

### Task 1.4: Hang Detector (MVP Feature #1)
**Time**: 2 hours
**Priority**: HIGH

**Steps:**
1. [ ] Create `HangDetector` class
   ```typescript
   class HangDetector {
     async detect(
       command: string,
       args: string[],
       timeout: number,
       sampleInterval: number
     ): Promise<HangResult>
   }
   ```

2. [ ] Implement periodic stack sampling
3. [ ] Detect repeated stack locations
4. [ ] Capture hang location and stack
5. [ ] Handle process completion
6. [ ] Clean up resources

**Acceptance Criteria:**
- Detects when process hangs (same location for 5+ seconds)
- Returns hang location and call stack
- Handles normal completion
- Cleans up properly

---

### Task 1.5: MCP Tool: detect_hang
**Time**: 1 hour
**Priority**: HIGH

**Steps:**
1. [ ] Implement MCP tool handler
   ```typescript
   {
     name: 'debugger_detect_hang',
     description: 'Run command and detect if it hangs',
     inputSchema: { ... },
     async handler(args) { ... }
   }
   ```

2. [ ] Validate input parameters
3. [ ] Call HangDetector
4. [ ] Format response
5. [ ] Handle errors

**Acceptance Criteria:**
- Tool can be called via MCP
- Returns hang detection results
- Provides useful error messages

---

### Task 1.6: Session Manager
**Time**: 1 hour
**Priority**: MEDIUM

**Steps:**
1. [ ] Create `SessionManager` class
   ```typescript
   class SessionManager {
     sessions = new Map<string, DebugSession>();
     
     create(options: SessionOptions): DebugSession
     get(id: string): DebugSession
     delete(id: string): void
     cleanup(): void
   }
   ```

2. [ ] Implement session lifecycle
3. [ ] Generate unique session IDs
4. [ ] Track active sessions
5. [ ] Clean up on exit

**Acceptance Criteria:**
- Can create and track sessions
- Sessions have unique IDs
- Cleanup works properly

---

### Task 1.7: MCP Tool: start_debug
**Time**: 1 hour
**Priority**: MEDIUM

**Steps:**
1. [ ] Implement MCP tool handler
   ```typescript
   {
     name: 'debugger_start',
     description: 'Start process with debugger attached',
     inputSchema: { ... },
     async handler(args) { ... }
   }
   ```

2. [ ] Spawn process with inspector
3. [ ] Create debug session
4. [ ] Enable debugger
5. [ ] Return session info

**Acceptance Criteria:**
- Can start process with debugger
- Returns session ID
- Process is paused at start

---

### Task 1.8: MCP Tool: inspect_variable
**Time**: 1.5 hours
**Priority**: MEDIUM

**Steps:**
1. [ ] Implement variable inspection
   ```typescript
   async function inspectVariable(
     session: DebugSession,
     expression: string
   ): Promise<any>
   ```

2. [ ] Get current call frame
3. [ ] Evaluate expression in context
4. [ ] Serialize result
5. [ ] Handle complex objects

**Acceptance Criteria:**
- Can inspect variables when paused
- Returns variable values
- Handles objects, arrays, primitives

---

### Task 1.9: MCP Server Setup
**Time**: 1 hour
**Priority**: HIGH

**Steps:**
1. [ ] Create MCP server
   ```typescript
   const server = new Server({
     name: 'mcp-debugger',
     version: '0.1.0'
   }, {
     capabilities: {
       tools: {}
     }
   });
   ```

2. [ ] Register all tools
3. [ ] Set up stdio transport
4. [ ] Handle server lifecycle
5. [ ] Add logging

**Acceptance Criteria:**
- MCP server starts successfully
- Tools are registered
- Can receive tool calls
- Logs useful information

---

### Task 1.10: Testing & Validation
**Time**: 1.5 hours
**Priority**: HIGH

**Steps:**
1. [ ] Create test fixtures
   - [ ] `infinite-loop.js` - Simple infinite loop
   - [ ] `async-hang.js` - Hangs on async operation
   - [ ] `normal.js` - Completes normally

2. [ ] Test hang detection
   ```bash
   # Should detect hang
   node mcp-debugger detect-hang "node infinite-loop.js" --timeout 5000
   ```

3. [ ] Test with Jest
   ```bash
   # Should detect hanging test
   node mcp-debugger detect-hang "yarn test hanging.test.ts" --timeout 10000
   ```

4. [ ] Test variable inspection
5. [ ] Test error handling
6. [ ] Document findings

**Acceptance Criteria:**
- Detects infinite loops correctly
- Detects hanging async operations
- Works with Jest tests
- Handles errors gracefully

---

### Task 1.11: MCP Configuration
**Time**: 30 minutes
**Priority**: MEDIUM

**Steps:**
1. [ ] Create MCP config for workspace
   ```json
   {
     "mcpServers": {
       "debugger": {
         "command": "node",
         "args": ["tools/mcp-debugger/dist/index.js"],
         "disabled": false
       }
     }
   }
   ```

2. [ ] Add to `.kiro/settings/mcp.json`
3. [ ] Test MCP connection
4. [ ] Verify tools are available

**Acceptance Criteria:**
- MCP server is configured
- Kiro can see debugger tools
- Tools can be invoked

---

### Task 1.12: Documentation
**Time**: 30 minutes
**Priority**: MEDIUM

**Steps:**
1. [ ] Create README.md
   - [ ] Installation instructions
   - [ ] Usage examples
   - [ ] Tool descriptions
   - [ ] Troubleshooting

2. [ ] Add JSDoc comments
3. [ ] Create examples
4. [ ] Document limitations

**Acceptance Criteria:**
- README is clear and complete
- Examples work
- Code is documented

---

## Phase 2: Enhanced Features (Future)

### Task 2.1: Breakpoint Support
**Time**: 2 hours
**Priority**: LOW

- Set/remove breakpoints
- Continue execution
- Step over/into/out

### Task 2.2: Source Map Support
**Time**: 2 hours
**Priority**: LOW

- Load source maps
- Map compiled to source locations
- Show TypeScript locations

### Task 2.3: Advanced Inspection
**Time**: 2 hours
**Priority**: LOW

- Inspect object properties deeply
- Watch expressions
- Get call stack

### Task 2.4: Performance Optimization
**Time**: 1 hour
**Priority**: LOW

- Reduce CDP overhead
- Optimize sampling
- Batch commands

---

## Testing Strategy

### Unit Tests
```typescript
describe('InspectorClient', () => {
  it('should connect to inspector', async () => {
    const client = new InspectorClient();
    await client.connect(mockWsUrl);
    expect(client.connected).toBe(true);
  });
});

describe('HangDetector', () => {
  it('should detect infinite loop', async () => {
    const result = await detector.detect('node', ['infinite-loop.js'], 5000);
    expect(result.hung).toBe(true);
    expect(result.location).toContain('infinite-loop.js');
  });
});
```

### Integration Tests
```typescript
describe('MCP Debugger Integration', () => {
  it('should detect hanging Jest test', async () => {
    const result = await mcpCall('debugger_detect_hang', {
      command: 'yarn',
      args: ['test', 'hanging.test.ts'],
      timeout: 10000
    });
    
    expect(result.hung).toBe(true);
  });
});
```

---

## Success Criteria

### MVP Complete When:
- [x] Can detect hanging processes
- [x] Can identify hang location
- [x] Can inspect variables when paused
- [x] Works with Jest tests
- [x] Integrated with Kiro via MCP
- [x] Can debug the 3 hanging audit tests

### Quality Metrics:
- Hang detection accuracy: >95%
- False positive rate: <5%
- Detection time: <10 seconds
- Memory overhead: <50MB
- No crashes or hangs in debugger itself

---

## Timeline

**Day 1 (4 hours):**
- Task 1.1: Project setup (30 min)
- Task 1.2: Inspector client (2 hours)
- Task 1.3: Process spawner (1 hour)
- Task 1.4: Hang detector (start, 30 min)

**Day 2 (4 hours):**
- Task 1.4: Hang detector (finish, 1.5 hours)
- Task 1.5: MCP tool detect_hang (1 hour)
- Task 1.6: Session manager (1 hour)
- Task 1.7: MCP tool start_debug (30 min)

**Day 3 (2-3 hours):**
- Task 1.8: MCP tool inspect (1.5 hours)
- Task 1.9: MCP server setup (1 hour)
- Task 1.10: Testing (start, 30 min)

**Day 4 (2 hours):**
- Task 1.10: Testing (finish, 1 hour)
- Task 1.11: MCP configuration (30 min)
- Task 1.12: Documentation (30 min)

**Total: 10-12 hours**

---

## Risk Mitigation

### Risk: CDP Protocol Complexity
**Mitigation**: Start with minimal CDP commands, expand as needed

### Risk: Source Map Issues
**Mitigation**: Phase 2 feature, not required for MVP

### Risk: Test Framework Integration
**Mitigation**: Test with simple scripts first, then Jest

### Risk: Performance Overhead
**Mitigation**: Optimize sampling interval, use efficient serialization

---

## Next Steps

1. Create project structure
2. Implement inspector client
3. Build hang detector
4. Create MCP tools
5. Test with hanging audit tests
6. Document and deploy
