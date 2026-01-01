# Implementation Plan: Fix ECIESService Constructor Signature

## Overview

This plan implements the TypeScript signature fix for the `ECIESService` constructor in both `@digitaldefiance/ecies-lib` (browser) and `@digitaldefiance/node-ecies-lib` (Node.js). The fix enables passing `IConstants` from `createRuntimeConfiguration` directly to the constructor while maintaining full backward compatibility.

## Tasks

- [x] 1. Update browser library constructor signature
  - Modify `packages/digitaldefiance-ecies-lib/src/services/ecies/service.ts`
  - Add import for `IConstants` type
  - Update constructor signature to accept `Partial<IECIESConfig> | IConstants`
  - Add type guard to distinguish between config types
  - Extract ECIES config from `IConstants` when needed
  - _Requirements: 1.1, 1.2, 1.3, 1.4_

- [x] 1.1 Write unit tests for browser library constructor
  - Test constructor accepts `IConstants` without TypeScript errors
  - Test constructor accepts `Partial<IECIESConfig>` without TypeScript errors
  - Test constructor with no parameters uses defaults
  - Test ECIES config extraction from `IConstants`
  - Test backward compatibility with existing usage patterns
  - _Requirements: 1.1, 1.2, 1.3, 5.1, 5.2_

- [x] 1.2 Write property test for IConstants acceptance (browser)
  - **Property 1: IConstants Acceptance**
  - **Validates: Requirements 1.1**

- [x] 1.3 Write property test for backward compatibility (browser)
  - **Property 2: Backward Compatibility**
  - **Validates: Requirements 5.1, 5.2**

- [x] 1.4 Write property test for configuration extraction (browser)
  - **Property 4: Configuration Extraction**
  - **Validates: Requirements 1.1**

- [x] 2. Update Node.js library constructor signature
  - Modify `packages/digitaldefiance-node-ecies-lib/src/services/ecies/service.ts`
  - Add import for `IConstants` type from `@digitaldefiance/ecies-lib`
  - Update constructor signature to accept `Partial<IECIESConfig> | IConstants`
  - Add type guard to distinguish between config types
  - Extract ECIES config from `IConstants` when needed
  - _Requirements: 2.1, 2.2, 2.3, 2.4_

- [x] 2.1 Write unit tests for Node.js library constructor
  - Test constructor accepts `IConstants` without TypeScript errors
  - Test constructor accepts `Partial<IECIESConfig>` without TypeScript errors
  - Test constructor with no parameters uses defaults
  - Test ECIES config extraction from `IConstants`
  - Test backward compatibility with existing usage patterns
  - _Requirements: 2.1, 2.2, 2.3, 5.1, 5.2_

- [x] 2.2 Write property test for IConstants acceptance (Node.js)
  - **Property 1: IConstants Acceptance**
  - **Validates: Requirements 2.1**

- [x] 2.3 Write property test for backward compatibility (Node.js)
  - **Property 2: Backward Compatibility**
  - **Validates: Requirements 5.1, 5.2**

- [x] 2.4 Write property test for configuration extraction (Node.js)
  - **Property 4: Configuration Extraction**
  - **Validates: Requirements 2.1**

- [x] 3. Checkpoint - Ensure all tests pass
  - Ensure all tests pass, ask the user if questions arise.

- [x] 4. Verify documented usage pattern
  - Test the exact code example from README compiles without errors
  - Verify both libraries accept the same documented pattern
  - _Requirements: 4.1, 4.2, 4.3_

- [x] 4.1 Write integration test for documented usage pattern
  - Test browser library with `createRuntimeConfiguration` example
  - Test Node.js library with `createRuntimeConfiguration` example
  - Verify no type assertions needed
  - _Requirements: 4.1, 4.2, 4.3_

- [x] 4.2 Write property test for cross-platform consistency
  - **Property 3: Cross-Platform Consistency**
  - **Validates: Requirements 3.1, 3.2**

- [x] 5. Update browser library README
  - Update `packages/digitaldefiance-ecies-lib/README.md`
  - Ensure all code examples show the correct constructor signature
  - Add note about accepting both `IConstants` and `Partial<IECIESConfig>`
  - Verify Quick Start examples are accurate
  - _Requirements: 4.1, 4.2, 4.3_

- [x] 6. Update Node.js library README
  - Update `packages/digitaldefiance-node-ecies-lib/README.md`
  - Ensure all code examples show the correct constructor signature
  - Add note about accepting both `IConstants` and `Partial<IECIESConfig>`
  - Verify Quick Start examples are accurate
  - _Requirements: 4.1, 4.2, 4.3_

- [x] 7. Review and update showcase examples (if needed)
  - Review `packages/digitaldefiance-ecies-lib/showcase/src/components/Demo.tsx`
  - Review `packages/digitaldefiance-node-ecies-lib/showcase/src/components/Demo.tsx`
  - Update if examples demonstrate the new constructor signature
  - Ensure showcase examples compile without errors
  - _Requirements: 4.1, 4.2, 4.3_

- [ ] 8. Final checkpoint - Ensure all tests pass
  - Ensure all tests pass, ask the user if questions arise.

## Notes

- Each task references specific requirements for traceability
- Checkpoints ensure incremental validation
- Property tests validate universal correctness properties with minimum 100 iterations
- Unit tests validate specific examples and edge cases
- The fix must be applied identically to both browser and Node.js libraries
- No breaking changes to the public API
- All existing code must continue to work without modification
