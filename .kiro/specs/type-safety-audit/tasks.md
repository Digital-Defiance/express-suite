# Implementation Plan: Type Safety Audit and Remediation

- [x] 1. Create global ambient type declarations
  - Create `types/global.d.ts` for Error and globalThis extensions
  - Create `types/window.d.ts` for Window interface extensions
  - Add type definitions for Error.captureStackTrace, Error properties, and GlobalActiveContext
  - _Requirements: 1.1, 2.1, 5.3_

- [x] 2. Phase 1: Fix digitaldefiance-i18n-lib (~20 instances)
- [x] 2.1 Create typed error class infrastructure
  - Create `src/errors/typed-error.ts` with TypedError class
  - Add properties: type, componentId, reasonMap, metadata
  - Support cause chaining
  - _Requirements: 1.2, 3.1_

- [x] 2.2 Replace error property assignments with TypedError
  - Update all `(error as any).type = ...` to use TypedError constructor
  - Update all `(error as any).metadata = ...` to use TypedError constructor
  - Update error throwing sites to use new TypedError class
  - _Requirements: 1.2_

- [x] 2.3 Fix empty object initializations
  - Replace `{} as any` with proper type initialization or Partial<T>
  - Add proper type annotations to object literals
  - _Requirements: 1.2_

- [x] 2.4 Fix enum translation type issues
  - Add proper generic constraints to enum translation functions
  - Replace `langTranslations[value as any]` with type-safe access
  - _Requirements: 1.2, 1.5_

- [x] 2.5 Fix global context with ambient declaration
  - Use ambient declaration from types/global.d.ts
  - Remove `(globalThis as any).GlobalActiveContext` casts
  - _Requirements: 1.1, 5.3_

- [x] 2.6 Define I18n engine interface
  - Create `src/types/engine.ts` with II18nEngine interface
  - Define all methods: translate, translateEnum, setLanguage, getLanguage
  - Add proper generic constraints for string keys
  - _Requirements: 1.5_

- [x] 2.7 Update i18n engine functions to return typed interface
  - Update function signatures to return II18nEngine
  - Ensure implementation matches interface
  - _Requirements: 1.5_

- [x] 2.8 Write property test for error class preservation
  - **Property: Typed error preserves all properties**
  - **Validates: Requirements 3.1**

- [x] 2.9 Write unit tests for i18n-lib fixes
  - Test TypedError class with all property combinations
  - Test enum translation type safety
  - Test global context access
  - _Requirements: 1.2, 3.1_

- [x] 2.10 Verify i18n-lib builds and tests pass
  - Run `tsc --noEmit` to verify no type errors
  - Run `npm run lint` to verify ESLint passes
  - Run `npm test` to verify all tests pass
  - Run `npm run build` to verify package builds
  - _Requirements: 6.5_

- [x] 2.11 Publish i18n-lib
  - Bump version appropriately (likely minor version)
  - Publish to npm registry
  - Document breaking changes if any
  - _Requirements: 6.2_

- [x] 3. Phase 2: Fix digitaldefiance-ecies-lib (~60 instances)
- [x] 3.1 Update package.json to use new i18n-lib version
  - Update dependency version to newly published i18n-lib
  - Run `npm install`
  - _Requirements: 6.3_

- [x] 3.2 Remove all i18n engine type casts (32 instances)
  - Replace `getEciesI18nEngine() as any` with properly typed calls
  - Verify TypeScript infers correct types
  - _Requirements: 1.2_

- [x] 3.3 Fix Error.captureStackTrace with ambient declaration
  - Use ambient declaration from types/global.d.ts
  - Remove `(Error as any).captureStackTrace` casts
  - _Requirements: 1.1, 5.3_

- [x] 3.4 Fix error cause handling
  - Use ambient Error.cause declaration
  - Remove `(options as any).cause` casts
  - _Requirements: 1.1, 5.3_

- [x] 3.5 Create deep clone with better generic constraints
  - Define Cloneable type union
  - Update deepClone function with proper constraints
  - Remove `as unknown as T` casts where possible
  - _Requirements: 1.1, 1.5_

- [x] 3.6 Fix builder type conversions
  - Add proper generic constraints to builder methods
  - Replace `as unknown as Uint8Array` with type guards
  - _Requirements: 1.1_

- [x] 3.7 Fix constants and utility type issues
  - Add proper index signatures for dynamic property access
  - Replace `(target as any)[key]` with type-safe patterns
  - _Requirements: 1.2_

- [x] 3.8 Write property test for deep clone type preservation
  - **Property: Deep clone preserves type and value**
  - **Validates: Requirements 1.1**

- [x] 3.9 Write unit tests for ecies-lib fixes
  - Test deep clone with various types
  - Test builder type conversions
  - Test error handling
  - _Requirements: 1.1, 1.2_

- [x] 3.10 Verify ecies-lib builds and tests pass
  - Run `tsc --noEmit` to verify no type errors
  - Run `npm run lint` to verify ESLint passes
  - Run `npm test` to verify all tests pass
  - Run `npm run build` to verify package builds
  - _Requirements: 6.5_

- [x] 3.11 Publish ecies-lib
  - Bump version appropriately
  - Publish to npm registry
  - Document breaking changes if any
  - _Requirements: 6.2_

- [x] 4. Phase 3: Fix digitaldefiance-node-ecies-lib (~20 instances)
- [x] 4.1 Update package.json to use new ecies-lib version
  - Update dependency version to newly published ecies-lib
  - Run `npm install`
  - _Requirements: 6.3_

- [x] 4.2 Create ID type guards and converters
  - Create `src/types/id-guards.ts` with isBuffer, isUint8Array
  - Create convertId function with proper type guards
  - _Requirements: 1.1, 1.5_

- [x] 4.3 Fix ID type conversions
  - Replace `as unknown as Uint8Array` with type guards
  - Replace `as unknown as Buffer` with type guards
  - Use convertId function where appropriate
  - _Requirements: 1.1_

- [x] 4.4 Import proper crypto types
  - Import Cipher, Decipher from 'crypto' module
  - Define AuthenticatedCipher and AuthenticatedDecipher interfaces
  - _Requirements: 1.1, 1.5_

- [x] 4.5 Fix cipher type assertions
  - Replace `as unknown as AuthenticatedCipher` with proper types
  - Replace `as unknown as AuthenticatedDecipher` with proper types
  - _Requirements: 1.1_

- [x] 4.6 Fix member ID serialization
  - Use type guards for ID conversions in member.ts
  - Remove `as unknown` casts from ID operations
  - _Requirements: 1.1_

- [x] 4.7 Write property test for ID type conversions
  - **Property: ID conversion preserves value**
  - **Validates: Requirements 1.1**

- [x] 4.8 Write unit tests for node-ecies-lib fixes
  - Test ID type guards
  - Test ID conversions
  - Test cipher type handling
  - _Requirements: 1.1_

- [x] 4.9 Verify node-ecies-lib builds and tests pass
  - Run `tsc --noEmit` to verify no type errors
  - Run `npm run lint` to verify ESLint passes
  - Run `npm test` to verify all tests pass
  - Run `npm run build` to verify package builds
  - _Requirements: 6.5_

- [x] 4.10 Publish node-ecies-lib
  - Bump version appropriately
  - Publish to npm registry
  - Document breaking changes if any
  - _Requirements: 6.2_

- [x] 5. Phase 4: Fix digitaldefiance-suite-core-lib (~5 instances)
- [x] 5.1 Update package.json to use new i18n-lib version
  - Update dependency version to newly published i18n-lib
  - Run `npm install`
  - _Requirements: 6.3_

- [x] 5.2 Fix deep clone operations
  - Apply same deep clone improvements as ecies-lib
  - Use Cloneable type union
  - Remove `as unknown as T` casts
  - _Requirements: 1.1_

- [x] 5.3 Fix dynamic property access in generic functions
  - Add proper index signatures or type guards
  - Replace `(obj as any)[prop]` with type-safe patterns
  - _Requirements: 1.2_

- [x] 5.4 Write unit tests for suite-core-lib fixes
  - Test deep clone functionality
  - Test dynamic property access
  - _Requirements: 1.1, 1.2_

- [x] 5.5 Verify suite-core-lib builds and tests pass
  - Run `tsc --noEmit` to verify no type errors
  - Run `npm run lint` to verify ESLint passes
  - Run `npm test` to verify all tests pass
  - Run `npm run build` to verify package builds
  - _Requirements: 6.5_

- [x] 5.6 Publish suite-core-lib
  - Bump version appropriately
  - Publish to npm registry
  - Document breaking changes if any
  - _Requirements: 6.2_

- [x] 6. Phase 5: Fix digitaldefiance-node-express-suite (~55 instances)
- [x] 6.1 Update package.json to use new versions
  - Update suite-core-lib dependency
  - Update node-ecies-lib dependency
  - Run `npm install`
  - _Requirements: 6.3_

- [x] 6.2 Create environment variable type-safe access
  - Create EnvironmentVariables interface with index signature
  - Create type-safe getEnvVar function
  - _Requirements: 1.2, 1.5_

- [x] 6.3 Fix environment variable access
  - Replace `(obj as any)[key]` with type-safe access
  - Replace `(environment as any)[envVar]` with proper types
  - _Requirements: 1.2_

- [x] 6.4 Fix ID conversions with type guards
  - Use ID type guards from node-ecies-lib
  - Replace `as unknown as I` with proper conversions
  - _Requirements: 1.1_

- [x] 6.5 Create proper service type interfaces
  - Define interfaces for all service types
  - Remove service type assertions
  - _Requirements: 1.2, 1.5_

- [x] 6.6 Fix middleware function wrapping
  - Add proper function type signatures
  - Remove `as unknown as typeof res.end` casts
  - _Requirements: 1.1_

- [x] 6.7 Fix model hydration
  - Add proper type parameters to Model.hydrate calls
  - Remove `as any` casts from hydrate operations
  - _Requirements: 1.2_

- [x] 6.8 Fix transaction manager callback types
  - Add proper generic constraints to withTransaction
  - Remove `as any` from callback parameter
  - _Requirements: 1.2_

- [x] 6.9 Fix timezone constructor access
  - Add proper type definition for timezone constructor
  - Remove `as any` from constructor access
  - _Requirements: 1.2_

- [x] 6.10 Fix controller handler invocation
  - Add proper handler type signatures
  - Remove `as any` from handler calls
  - _Requirements: 1.2_

- [x] 6.11 Write property test for environment variable access
  - **Property: Environment access is type-safe**
  - **Validates: Requirements 1.2**

- [x] 6.12 Write unit tests for node-express-suite fixes
  - Test environment variable access
  - Test ID conversions
  - Test service type handling
  - Test middleware wrapping
  - _Requirements: 1.1, 1.2_

- [x] 6.13 Verify node-express-suite builds and tests pass
  - Run `tsc --noEmit` to verify no type errors
  - Run `npm run lint` to verify ESLint passes
  - Run `npm test` to verify all tests pass
  - Run `npm run build` to verify package builds
  - _Requirements: 6.5_

- [x] 6.14 Publish node-express-suite
  - Bump version appropriately
  - Publish to npm registry
  - Document breaking changes if any
  - _Requirements: 6.2_

- [-] 7. Phase 6: Fix digitaldefiance-express-suite-react-components (~3 instances)
- [x] 7.1 Update package.json to use new suite-core-lib version
  - Update dependency version to newly published suite-core-lib
  - Run `npm install`
  - _Requirements: 6.3_

- [x] 7.2 Fix Window.APP_CONFIG with ambient declaration
  - Use ambient declaration from types/window.d.ts
  - Remove `(window as any).APP_CONFIG` cast
  - Define IAppConfig interface based on actual structure
  - _Requirements: 1.2, 5.3_

- [x] 7.3 Fix navigation state type
  - Add proper type definition for navigation link state
  - Remove `(option.link as any).state` cast
  - _Requirements: 1.2_

- [ ] 7.4 Write unit tests for react-components fixes
  - Test Window.APP_CONFIG access
  - Test navigation state handling
  - _Requirements: 1.2_

- [x] 7.5 Verify react-components builds and tests pass
  - Run `tsc --noEmit` to verify no type errors
  - Run `npm run lint` to verify ESLint passes
  - Run `npm test` to verify all tests pass
  - Run `npm run build` to verify package builds
  - _Requirements: 6.5_

- [ ] 7.6 Publish express-suite-react-components
  - Bump version appropriately
  - Publish to npm registry
  - Document breaking changes if any
  - _Requirements: 6.2_cd

- [ ] 8. Phase 7: Fix digitaldefiance-express-suite-starter (~1 instance)
- [ ] 8.1 Update package.json to use new node-express-suite version
  - Update dependency version to newly published node-express-suite
  - Run `npm install`
  - _Requirements: 6.3_

- [ ] 8.2 Fix plugin hook invocation
  - Add proper type signature for plugin hooks
  - Remove `await (hook as any)(...args, context)` cast
  - _Requirements: 1.2_

- [ ] 8.3 Write unit tests for starter fixes
  - Test plugin hook invocation
  - _Requirements: 1.2_

- [ ] 8.4 Verify starter builds and tests pass
  - Run `tsc --noEmit` to verify no type errors
  - Run `npm run lint` to verify ESLint passes
  - Run `npm test` to verify all tests pass
  - Run `npm run build` to verify package builds
  - _Requirements: 6.5_

- [ ] 8.5 Publish express-suite-starter
  - Bump version appropriately
  - Publish to npm registry
  - Document breaking changes if any
  - _Requirements: 6.2_

- [x] 9. Update ESLint configuration for stricter type safety
  - Update root `.eslintrc.json` with stricter rules
  - Change `@typescript-eslint/no-explicit-any` from "warn" to "error"
  - Add `@typescript-eslint/no-unsafe-assignment: "error"`
  - Add `@typescript-eslint/no-unsafe-call: "error"`
  - Add `@typescript-eslint/no-unsafe-member-access: "error"`
  - Add `@typescript-eslint/no-unsafe-return: "error"`
  - Add `@typescript-eslint/no-unsafe-argument: "error"`
  - _Requirements: 3.1, 3.2, 3.3, 3.4, 3.5, 5.2_

- [x] 10. Consider additional TypeScript strict options
  - Evaluate adding `noUncheckedIndexedAccess: true` to tsconfig.base.json
  - Evaluate adding `exactOptionalPropertyTypes: true` to tsconfig.base.json
  - Test impact on codebase
  - _Requirements: 5.1_

- [x] 11. Set up pre-commit hooks for type safety
  - Install Husky if not already installed
  - Create pre-commit hook to run `tsc --noEmit`
  - Create pre-commit hook to run `npm run lint`
  - Test hooks prevent commits with type errors
  - _Requirements: 5.4_

- [x] 12. Final verification across all packages
  - Verify all packages build successfully
  - Verify all tests pass
  - Verify no type casts remain in production code
  - Run full monorepo build
  - _Requirements: 4.5, 6.5_

- [x] 13. Create type safety audit report
  - Document all fixes made
  - List remaining acceptable type casts (if any)
  - Document new type safety patterns established
  - Create guidelines for future development
  - _Requirements: 4.1, 4.2, 4.3, 4.4, 4.5_
