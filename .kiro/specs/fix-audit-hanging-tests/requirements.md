# Fix Audit Tool Hanging Tests - Requirements

## Overview
Three test files in the audit tool hang indefinitely and need to be fixed. These tests are critical for ensuring the audit tool works correctly in production.

## Current Status
- **Working**: 245 tests passing in 36 seconds (14 test suites)
- **Broken**: 3 test files hang indefinitely
  - `cli.test.ts` - 8 tests
  - `orchestrator.test.ts` - 17 tests  
  - `export-validator.test.ts` - 22 tests
- **Total blocked**: ~47 tests

## Problem Statement
The three test files hang indefinitely when run, blocking the test suite from completing. This prevents:
1. Full test coverage validation
2. CI/CD pipeline completion
3. Confidence in production deployments
4. Verification of critical functionality

## Requirements

### 1. Fix `cli.test.ts` (Priority: HIGH)
**Acceptance Criteria:**
- [ ] All CLI tests complete within 30 seconds
- [ ] Tests verify CLI commands work correctly
- [ ] Tests handle build requirements properly
- [ ] No hanging or infinite loops

**Current Issues:**
- Hangs even after running `yarn build`
- Likely issue: CLI process not terminating, or waiting for stdin/stdout

### 2. Fix `orchestrator.test.ts` (Priority: HIGH)
**Acceptance Criteria:**
- [ ] All orchestrator tests complete within 60 seconds
- [ ] Tests verify full audit workflow
- [ ] Tests verify incremental audit workflow
- [ ] Tests verify package audit workflow
- [ ] No hanging or infinite loops

**Current Issues:**
- Hangs when running full audits
- Likely issue: Calls expensive parsers (TypeScript compiler) repeatedly
- May need mocking or reduced test data

### 3. Fix `export-validator.test.ts` (Priority: HIGH)
**Acceptance Criteria:**
- [ ] All export validator tests complete within 45 seconds
- [ ] Tests verify export documentation validation
- [ ] Tests verify multiple package validation
- [ ] No hanging or infinite loops

**Current Issues:**
- Hangs on basic tests like `validateExportsDocumented`
- Likely issue: Infinite loop in validation logic or TypeScript parser
- Other validators work fine, so issue is specific to this one

## Success Criteria
1. All 3 test files run successfully
2. Total test suite completes in under 2 minutes
3. All ~292 tests passing (245 current + 47 blocked)
4. No test hangs or timeouts
5. Tests can run in CI/CD without issues

## Constraints
- Must maintain test quality and coverage
- Cannot skip important test cases
- Must use FAST_TESTS mode for reasonable execution time
- Should not require major refactoring of source code

## Dependencies
- TypeScript compiler API (potential bottleneck)
- File system operations (temp directories)
- Child process execution (CLI tests)
- Jest test framework

## Out of Scope
- Performance optimization beyond fixing hangs
- Adding new test cases
- Refactoring working tests
- Changing test framework

## Timeline
- Investigation: 1-2 hours
- Implementation: 2-4 hours
- Verification: 1 hour
- Total: 4-7 hours

## Risks
1. **Root cause unclear**: May need significant debugging
2. **TypeScript parser**: May be inherently slow, requiring mocks
3. **Integration complexity**: Orchestrator tests may need substantial changes
4. **Regression**: Fixes might break other tests
