# Fix Audit Tool Hanging Tests - Tasks

## Phase 1: Investigation & Root Cause Analysis

### Task 1.1: Investigate CLI Test Hangs
**Estimated Time**: 30 minutes
**Priority**: HIGH

**Steps:**
1. [ ] Add individual test timeouts to identify which test hangs
2. [ ] Add console.log statements to trace execution
3. [ ] Check if `execSync` is properly configured with stdio
4. [ ] Verify CLI process terminates correctly
5. [ ] Document root cause

**Acceptance Criteria:**
- Identify which specific CLI test hangs
- Understand why it hangs
- Document findings

### Task 1.2: Investigate Orchestrator Test Hangs
**Estimated Time**: 30 minutes
**Priority**: HIGH

**Steps:**
1. [ ] Add individual test timeouts to identify which test hangs
2. [ ] Profile execution to find slow operations
3. [ ] Check if TypeScript parser is being called
4. [ ] Verify temp directory cleanup
5. [ ] Document root cause

**Acceptance Criteria:**
- Identify which orchestrator test hangs
- Understand performance bottleneck
- Document findings

### Task 1.3: Investigate Export Validator Test Hangs
**Estimated Time**: 30 minutes
**Priority**: HIGH

**Steps:**
1. [ ] Add individual test timeouts to identify which test hangs
2. [ ] Add console.log to trace execution flow
3. [ ] Check for infinite loops in validation logic
4. [ ] Verify TypeScript parser completes
5. [ ] Document root cause

**Acceptance Criteria:**
- Identify which export validator test hangs
- Understand root cause (infinite loop, blocking call, etc.)
- Document findings

## Phase 2: Create Test Fixtures

### Task 2.1: Create Test Fixture Structure
**Estimated Time**: 30 minutes
**Priority**: MEDIUM

**Steps:**
1. [ ] Create `tests/fixtures/` directory
2. [ ] Create `simple-package` fixture
   - [ ] package.json
   - [ ] src/index.ts (1-2 exports)
   - [ ] README.md (minimal)
3. [ ] Create `documented-package` fixture
   - [ ] package.json
   - [ ] src/index.ts (2-3 exports)
   - [ ] README.md (with documentation)
4. [ ] Create `undocumented-package` fixture
   - [ ] package.json
   - [ ] src/index.ts (2-3 exports)
   - [ ] README.md (no documentation)

**Acceptance Criteria:**
- Fixtures exist and are valid packages
- Can be used in tests without modification
- Cover common test scenarios

## Phase 3: Fix CLI Tests

### Task 3.1: Refactor CLI for Testability
**Estimated Time**: 1 hour
**Priority**: HIGH

**Steps:**
1. [ ] Extract CLI logic into testable functions
2. [ ] Export functions from `src/cli.ts`
3. [ ] Separate command parsing from execution
4. [ ] Add timeout parameter to CLI functions

**Acceptance Criteria:**
- CLI functions can be imported and tested directly
- No breaking changes to CLI behavior
- Functions have reasonable timeouts

### Task 3.2: Update CLI Tests
**Estimated Time**: 1 hour
**Priority**: HIGH

**Steps:**
1. [ ] Import CLI functions instead of using `execSync`
2. [ ] Test functions directly for most tests
3. [ ] Keep 1-2 integration tests with real CLI
4. [ ] Add explicit timeouts to remaining `execSync` calls
5. [ ] Add `stdio: 'pipe'` to `execSync` options

**Acceptance Criteria:**
- All CLI tests pass
- Tests complete in < 10 seconds
- No hangs or timeouts

## Phase 4: Fix Orchestrator Tests

### Task 4.1: Create Mocks for Expensive Operations
**Estimated Time**: 45 minutes
**Priority**: HIGH

**Steps:**
1. [ ] Create mock for `parseTypeScriptExports`
2. [ ] Create mock for `analyzePackage`
3. [ ] Return realistic test data from mocks
4. [ ] Document mock usage

**Acceptance Criteria:**
- Mocks return valid data structures
- Mocks are reusable across tests
- Documentation explains when to use mocks

### Task 4.2: Update Orchestrator Tests
**Estimated Time**: 1.5 hours
**Priority**: HIGH

**Steps:**
1. [ ] Use test fixtures instead of generating packages
2. [ ] Mock `parseTypeScriptExports` in fast mode
3. [ ] Reduce test package complexity
4. [ ] Add timeouts to audit operations
5. [ ] Keep 1-2 tests with real parsing (full mode)

**Acceptance Criteria:**
- All orchestrator tests pass
- Tests complete in < 30 seconds (fast mode)
- Tests complete in < 2 minutes (full mode)
- No hangs or timeouts

## Phase 5: Fix Export Validator Tests

### Task 5.1: Add Timeout Protection
**Estimated Time**: 30 minutes
**Priority**: HIGH

**Steps:**
1. [ ] Add timeout parameter to `validateExportsDocumented`
2. [ ] Add timeout checks in validation loops
3. [ ] Add timeout to TypeScript parsing calls
4. [ ] Throw timeout error if exceeded

**Acceptance Criteria:**
- Validation functions have timeout protection
- Timeout errors are clear and actionable
- Default timeout is reasonable (10-15 seconds)

### Task 5.2: Fix Infinite Loop (if found)
**Estimated Time**: 1 hour
**Priority**: HIGH

**Steps:**
1. [ ] Identify infinite loop location
2. [ ] Add loop guards or break conditions
3. [ ] Add unit tests for edge cases
4. [ ] Verify fix doesn't break other tests

**Acceptance Criteria:**
- No infinite loops in validation logic
- Edge cases are handled correctly
- All tests pass

### Task 5.3: Update Export Validator Tests
**Estimated Time**: 1 hour
**Priority**: HIGH

**Steps:**
1. [ ] Use test fixtures instead of generating packages
2. [ ] Mock `analyzePackage` in fast mode
3. [ ] Simplify test packages
4. [ ] Add explicit timeouts to tests
5. [ ] Keep 1-2 tests with real parsing (full mode)

**Acceptance Criteria:**
- All export validator tests pass
- Tests complete in < 30 seconds (fast mode)
- No hangs or timeouts

## Phase 6: Integration & Verification

### Task 6.1: Update Jest Configuration
**Estimated Time**: 15 minutes
**Priority**: MEDIUM

**Steps:**
1. [ ] Remove skipped tests from `testPathIgnorePatterns`
2. [ ] Update test scripts in package.json
3. [ ] Verify configuration is correct

**Acceptance Criteria:**
- All tests are included in default run
- Configuration is clean and documented

### Task 6.2: Run Full Test Suite
**Estimated Time**: 30 minutes
**Priority**: HIGH

**Steps:**
1. [ ] Run `FAST_TESTS=true yarn test:audit`
2. [ ] Verify all ~292 tests pass
3. [ ] Verify completion time < 2 minutes
4. [ ] Run `yarn test:audit:full`
5. [ ] Verify completion time < 5 minutes

**Acceptance Criteria:**
- All tests pass in both modes
- No hangs or timeouts
- Performance targets met

### Task 6.3: Update Documentation
**Estimated Time**: 30 minutes
**Priority**: MEDIUM

**Steps:**
1. [ ] Update TESTING.md with new status
2. [ ] Document fixture usage
3. [ ] Document mocking strategy
4. [ ] Update test counts and timing

**Acceptance Criteria:**
- Documentation is accurate
- Examples are clear
- New developers can understand test structure

### Task 6.4: CI/CD Verification
**Estimated Time**: 15 minutes
**Priority**: HIGH

**Steps:**
1. [ ] Run tests in CI environment
2. [ ] Verify no hangs in CI
3. [ ] Verify performance is acceptable
4. [ ] Update CI configuration if needed

**Acceptance Criteria:**
- Tests pass in CI
- CI completes in reasonable time
- No special configuration needed

## Phase 7: Cleanup & Polish

### Task 7.1: Code Review & Cleanup
**Estimated Time**: 30 minutes
**Priority**: LOW

**Steps:**
1. [ ] Remove debug logging
2. [ ] Clean up commented code
3. [ ] Ensure consistent code style
4. [ ] Add JSDoc comments where needed

**Acceptance Criteria:**
- Code is clean and professional
- No debug artifacts remain
- Documentation is complete

### Task 7.2: Performance Optimization (Optional)
**Estimated Time**: 1 hour
**Priority**: LOW

**Steps:**
1. [ ] Profile test execution
2. [ ] Identify remaining slow tests
3. [ ] Optimize if possible
4. [ ] Document performance characteristics

**Acceptance Criteria:**
- Test suite runs as fast as possible
- Performance is documented
- No regressions

## Summary

**Total Estimated Time**: 10-12 hours
**Critical Path**: Investigation → CLI Fix → Orchestrator Fix → Export Validator Fix → Verification

**Milestones:**
1. **Investigation Complete** (1.5 hours) - Root causes identified
2. **CLI Tests Fixed** (2 hours) - CLI tests passing
3. **Orchestrator Tests Fixed** (2.5 hours) - Orchestrator tests passing
4. **Export Validator Tests Fixed** (2.5 hours) - Export validator tests passing
5. **Full Suite Passing** (1 hour) - All 292 tests passing
6. **Documentation Complete** (0.5 hours) - Everything documented

**Success Metrics:**
- ✅ All 292 tests passing
- ✅ Fast mode: < 2 minutes
- ✅ Full mode: < 5 minutes
- ✅ No hangs or timeouts
- ✅ CI/CD working
