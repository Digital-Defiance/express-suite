# Fix Audit Tool Hanging Tests - Design

## Investigation Strategy

### Phase 1: Identify Root Causes (1-2 hours)

#### 1.1 CLI Test Investigation
**Hypothesis**: CLI spawns child processes that don't terminate

**Investigation Steps:**
1. Add timeout to individual test cases
2. Add logging to identify which specific test hangs
3. Check if `execSync` is waiting for process to close
4. Verify stdin/stdout/stderr are properly closed
5. Check if CLI is waiting for user input

**Potential Solutions:**
- Use `stdio: 'pipe'` instead of default
- Add explicit timeout to `execSync` calls
- Mock CLI execution instead of running actual process
- Use `spawn` with explicit cleanup instead of `execSync`

#### 1.2 Orchestrator Test Investigation
**Hypothesis**: Runs full TypeScript parsing on real packages, causing extreme slowness

**Investigation Steps:**
1. Add timeout to individual test cases
2. Profile which function calls take longest
3. Check if it's creating real temp packages with many files
4. Verify cleanup is happening in `afterEach`
5. Check if TypeScript compiler is being called repeatedly

**Potential Solutions:**
- Mock `parseTypeScriptExports` to return fake data
- Reduce test package size (fewer files, simpler exports)
- Skip TypeScript parsing in orchestrator tests
- Use pre-built test fixtures instead of generating on-the-fly

#### 1.3 Export Validator Test Investigation
**Hypothesis**: Infinite loop or blocking call in validation logic

**Investigation Steps:**
1. Add timeout to individual test cases
2. Add console.log statements to trace execution
3. Check if `validateExportsDocumented` has infinite loop
4. Verify `analyzePackage` completes
5. Check if TypeScript parser hangs on specific code patterns

**Potential Solutions:**
- Add timeout to TypeScript parsing
- Fix infinite loop if found
- Mock `analyzePackage` to return fake data
- Simplify test package structure

### Phase 2: Implement Fixes (2-4 hours)

## Design Decisions

### Decision 1: Mock vs Real Execution

**Option A: Mock Heavy Operations**
- Pros: Fast, reliable, no hangs
- Cons: Less confidence in real behavior
- Use for: Unit tests, fast feedback

**Option B: Real Execution with Timeouts**
- Pros: Tests real behavior, catches real bugs
- Cons: Slower, may still timeout
- Use for: Integration tests, slower but thorough

**Recommendation**: 
- Use **Option A** for most tests (fast mode)
- Use **Option B** for a few critical integration tests (full mode)

### Decision 2: Test Data Strategy

**Option A: Generate Test Data On-The-Fly**
- Current approach
- Flexible but slow

**Option B: Use Pre-Built Fixtures**
- Faster, more predictable
- Less flexible

**Recommendation**: 
- Use **Option B** - Create fixture packages in `tests/fixtures/`
- Reduces file system operations
- Eliminates TypeScript compilation during tests

### Decision 3: CLI Testing Strategy

**Option A: Test Real CLI**
- Tests actual user experience
- Requires build step

**Option B: Test CLI Functions Directly**
- Faster, no build needed
- Doesn't test actual CLI invocation

**Recommendation**:
- Use **Option B** for most tests (import and call functions)
- Use **Option A** for 1-2 smoke tests only

## Implementation Plan

### Fix 1: CLI Tests

```typescript
// Instead of:
execSync(`node ${cliPath} --help`)

// Use:
import { runCLI } from '../src/cli';
const result = await runCLI(['--help']);

// Or with timeout:
execSync(`node ${cliPath} --help`, {
  timeout: 5000,
  stdio: 'pipe'
})
```

**Changes:**
1. Refactor CLI to export testable functions
2. Import and test functions directly
3. Keep 1-2 integration tests with real CLI execution
4. Add explicit timeouts to all `execSync` calls

### Fix 2: Orchestrator Tests

```typescript
// Mock expensive operations
jest.mock('../../src/parsers/typescript-parser', () => ({
  parseTypeScriptExports: jest.fn(() => [
    { name: 'testExport', type: 'function', signature: 'function testExport(): void', sourceFile: 'src/index.ts', isDocumented: false, hasExample: false }
  ])
}));

// Or use fixtures
const fixturePackage = path.join(__dirname, '../fixtures/simple-package');
const result = runPackageAudit(fixturePackage, options);
```

**Changes:**
1. Create test fixtures in `tests/fixtures/`
2. Mock `parseTypeScriptExports` in orchestrator tests
3. Reduce test package complexity
4. Add timeouts to all audit operations

### Fix 3: Export Validator Tests

```typescript
// Add timeout to validation
function validateExportsDocumented(packagePath: string, timeout = 10000): ValidationResult {
  const startTime = Date.now();
  
  // Add timeout checks in loops
  if (Date.now() - startTime > timeout) {
    throw new Error('Validation timeout');
  }
  
  // ... rest of validation
}

// Or mock in tests
jest.mock('../../src/analyzers/documentation-analyzer', () => ({
  analyzePackage: jest.fn(() => ({
    exports: [{ name: 'test', type: 'function', isDocumented: false }],
    documentedSymbols: []
  }))
}));
```

**Changes:**
1. Add timeout parameter to validation functions
2. Mock `analyzePackage` in tests
3. Simplify test packages
4. Add explicit timeout to TypeScript parsing

## Test Fixtures Structure

```
tests/fixtures/
├── simple-package/
│   ├── package.json
│   ├── README.md
│   └── src/
│       └── index.ts (1-2 simple exports)
├── documented-package/
│   ├── package.json
│   ├── README.md (with documentation)
│   └── src/
│       └── index.ts
└── undocumented-package/
    ├── package.json
    ├── README.md (minimal)
    └── src/
        └── index.ts
```

## Mocking Strategy

### What to Mock
1. **TypeScript Parser** - Slowest operation
2. **File System Operations** - When not testing I/O
3. **Child Processes** - CLI execution

### What NOT to Mock
1. **Validation Logic** - Core functionality
2. **Error Detection** - Critical behavior
3. **Report Generation** - Output formatting

## Testing Strategy

### Fast Mode (Default)
- Mock all expensive operations
- Use fixtures instead of generating packages
- Target: < 60 seconds for all tests

### Full Mode
- Real TypeScript parsing
- Generate test packages
- Target: < 5 minutes for all tests

## Rollback Plan

If fixes don't work:
1. Keep tests skipped but documented
2. Create separate integration test suite
3. Run integration tests manually before releases
4. Focus on unit testing individual functions

## Verification

After fixes:
1. Run `FAST_TESTS=true yarn test:audit` - should complete in < 60s
2. Run `yarn test:audit:full` - should complete in < 5 minutes
3. All ~292 tests should pass
4. No hangs or timeouts
5. CI/CD pipeline should complete successfully
