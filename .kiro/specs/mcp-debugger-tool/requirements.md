# MCP Debugger Tool - Requirements

## Overview
Build a Model Context Protocol (MCP) server that provides debugging capabilities for Node.js/TypeScript applications, allowing AI agents to interactively debug code.

## Problem Statement
Currently, AI agents can only debug by:
- Adding console.log statements
- Running tests with timeouts
- Reading code statically

This is insufficient for complex debugging scenarios like:
- Hanging tests
- Infinite loops
- Race conditions
- Memory leaks

## Goals
Create an MCP server that enables:
1. Setting breakpoints programmatically
2. Inspecting variables at runtime
3. Stepping through code execution
4. Evaluating expressions in context
5. Monitoring process state
6. Detecting hangs and infinite loops

## Use Cases

### Use Case 1: Debug Hanging Test
```
Agent: Set breakpoint at tools/audit/tests/validators/export-validator.test.ts:127
Agent: Run test with debugger attached
Agent: When breakpoint hits, inspect local variables
Agent: Step through execution to find where it hangs
Agent: Identify infinite loop or blocking call
```

### Use Case 2: Inspect Runtime State
```
Agent: Attach to running process PID 12345
Agent: Get call stack
Agent: Inspect variable 'exports' in current frame
Agent: Evaluate expression 'exports.length'
```

### Use Case 3: Detect Infinite Loop
```
Agent: Run test with hang detection
Agent: If execution exceeds 5 seconds, pause and inspect
Agent: Get current line number and call stack
Agent: Identify loop condition
```

## Requirements

### Functional Requirements

#### FR1: Breakpoint Management
- [ ] Set breakpoint by file and line number
- [ ] Set conditional breakpoints
- [ ] List all breakpoints
- [ ] Remove breakpoints
- [ ] Enable/disable breakpoints

#### FR2: Execution Control
- [ ] Start process with debugger attached
- [ ] Attach to running process
- [ ] Continue execution
- [ ] Step over (next line)
- [ ] Step into (enter function)
- [ ] Step out (exit function)
- [ ] Pause execution

#### FR3: Variable Inspection
- [ ] Get local variables in current scope
- [ ] Get global variables
- [ ] Inspect object properties
- [ ] Evaluate arbitrary expressions
- [ ] Watch variable changes

#### FR4: Call Stack
- [ ] Get current call stack
- [ ] Navigate stack frames
- [ ] Inspect variables in any frame

#### FR5: Process Monitoring
- [ ] Detect hanging processes
- [ ] Monitor CPU usage
- [ ] Monitor memory usage
- [ ] Detect infinite loops
- [ ] Set execution timeouts

#### FR6: Test Integration
- [ ] Run Jest tests with debugger
- [ ] Run Mocha tests with debugger
- [ ] Run Vitest tests with debugger
- [ ] Capture test output
- [ ] Report test failures with context

### Non-Functional Requirements

#### NFR1: Performance
- Minimal overhead when debugger attached
- Fast breakpoint evaluation
- Efficient variable serialization

#### NFR2: Compatibility
- Works with Node.js 18+
- Works with TypeScript via source maps
- Works with Jest, Mocha, Vitest
- Works on Linux, macOS, Windows

#### NFR3: Usability
- Simple MCP tool interface
- Clear error messages
- Good documentation
- Examples for common scenarios

#### NFR4: Reliability
- Doesn't crash target process
- Handles errors gracefully
- Cleans up resources properly

## MCP Tools Interface

### Tool: `debugger_set_breakpoint`
```json
{
  "name": "debugger_set_breakpoint",
  "description": "Set a breakpoint at a specific file and line",
  "inputSchema": {
    "type": "object",
    "properties": {
      "file": { "type": "string", "description": "File path" },
      "line": { "type": "number", "description": "Line number" },
      "condition": { "type": "string", "description": "Optional condition" }
    },
    "required": ["file", "line"]
  }
}
```

### Tool: `debugger_start`
```json
{
  "name": "debugger_start",
  "description": "Start a process with debugger attached",
  "inputSchema": {
    "type": "object",
    "properties": {
      "command": { "type": "string", "description": "Command to run" },
      "args": { "type": "array", "items": { "type": "string" } },
      "cwd": { "type": "string", "description": "Working directory" },
      "timeout": { "type": "number", "description": "Timeout in ms" }
    },
    "required": ["command"]
  }
}
```

### Tool: `debugger_continue`
```json
{
  "name": "debugger_continue",
  "description": "Continue execution until next breakpoint",
  "inputSchema": {
    "type": "object",
    "properties": {
      "sessionId": { "type": "string" }
    },
    "required": ["sessionId"]
  }
}
```

### Tool: `debugger_step_over`
```json
{
  "name": "debugger_step_over",
  "description": "Execute next line without entering functions",
  "inputSchema": {
    "type": "object",
    "properties": {
      "sessionId": { "type": "string" }
    },
    "required": ["sessionId"]
  }
}
```

### Tool: `debugger_inspect`
```json
{
  "name": "debugger_inspect",
  "description": "Inspect variables in current scope",
  "inputSchema": {
    "type": "object",
    "properties": {
      "sessionId": { "type": "string" },
      "expression": { "type": "string", "description": "Variable name or expression" }
    },
    "required": ["sessionId"]
  }
}
```

### Tool: `debugger_get_stack`
```json
{
  "name": "debugger_get_stack",
  "description": "Get current call stack",
  "inputSchema": {
    "type": "object",
    "properties": {
      "sessionId": { "type": "string" }
    },
    "required": ["sessionId"]
  }
}
```

### Tool: `debugger_detect_hang`
```json
{
  "name": "debugger_detect_hang",
  "description": "Run command and detect if it hangs",
  "inputSchema": {
    "type": "object",
    "properties": {
      "command": { "type": "string" },
      "args": { "type": "array", "items": { "type": "string" } },
      "timeout": { "type": "number", "description": "Timeout in ms" },
      "sampleInterval": { "type": "number", "description": "How often to check progress" }
    },
    "required": ["command", "timeout"]
  }
}
```

## Technical Approach

### Option 1: Node.js Inspector Protocol
- Use built-in `inspector` module
- Connect via Chrome DevTools Protocol
- Pros: Native, well-supported, powerful
- Cons: Complex protocol, requires WebSocket

### Option 2: V8 Inspector
- Use `--inspect` flag
- Connect via CDP
- Pros: Standard, works with existing tools
- Cons: Requires process restart

### Option 3: Custom Instrumentation
- Inject debugging code at runtime
- Use `vm` module for evaluation
- Pros: Simple, flexible
- Cons: Limited capabilities

**Recommendation**: Start with Option 1 (Inspector Protocol) for full capabilities

## Success Criteria
1. Can set breakpoints and pause execution
2. Can inspect variables at breakpoints
3. Can detect hanging tests within 10 seconds
4. Can step through code execution
5. Works with TypeScript via source maps
6. Integrates with Jest tests
7. AI agent can use it to debug the 3 hanging audit tests

## Out of Scope
- Visual debugger UI (use MCP tools only)
- Remote debugging over network
- Multi-process debugging
- Performance profiling (separate tool)
- Memory leak detection (separate tool)

## Dependencies
- Node.js `inspector` module
- Chrome DevTools Protocol
- Source map support
- MCP SDK

## Timeline
- Design & Prototype: 4-6 hours
- Core Implementation: 8-12 hours
- Testing & Refinement: 4-6 hours
- Documentation: 2-3 hours
- Total: 18-27 hours

## Risks
1. **Complexity**: CDP is complex, may take time to learn
2. **Source Maps**: TypeScript debugging requires proper source map handling
3. **Async Code**: Debugging async/await can be tricky
4. **Test Frameworks**: Each test framework may need special handling
5. **Stability**: Debugger might crash target process

## Future Enhancements
- Memory profiling
- CPU profiling
- Code coverage integration
- Automatic hang detection
- Smart breakpoint suggestions
- AI-powered debugging hints
