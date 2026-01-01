# Requirements Document

## Introduction

This specification addresses a TypeScript signature mismatch in the ECIESService constructor across both `@digitaldefiance/ecies-lib` (browser) and `@digitaldefiance/node-ecies-lib` (Node.js). The README documentation shows passing `IConstants` (from `createRuntimeConfiguration`) directly to `ECIESService`, but the TypeScript definition only accepts `Partial<IECIESConfig>`, causing type errors despite working at runtime.

## Glossary

- **ECIESService**: The main service class for ECIES encryption/decryption operations in both browser and Node.js environments
- **IConstants**: The complete runtime configuration interface returned by `createRuntimeConfiguration`, includes `idProvider` and all cryptographic constants
- **IECIESConfig**: A subset interface containing only ECIES-specific configuration parameters (curve name, key derivation path, symmetric algorithm settings)
- **createRuntimeConfiguration**: Factory function that creates a validated `IConstants` object with optional overrides
- **Type_Signature**: The TypeScript function signature that defines accepted parameter types
- **Runtime_Behavior**: The actual behavior of code when executed, which may differ from TypeScript types

## Requirements

### Requirement 1: Fix Browser Library Constructor Signature

**User Story:** As a developer using `@digitaldefiance/ecies-lib`, I want to pass `IConstants` from `createRuntimeConfiguration` directly to `ECIESService`, so that the TypeScript compiler accepts the documented usage pattern without requiring type assertions.

#### Acceptance Criteria

1. WHEN the ECIESService constructor is called with an `IConstants` object, THEN the TypeScript compiler SHALL accept it without errors
2. WHEN the ECIESService constructor is called with `Partial<IECIESConfig>`, THEN the TypeScript compiler SHALL continue to accept it for backward compatibility
3. WHEN the ECIESService constructor signature is updated, THEN all existing usage patterns SHALL remain valid
4. THE ECIESService constructor SHALL import `IConstants` from the correct module path

### Requirement 2: Fix Node.js Library Constructor Signature

**User Story:** As a developer using `@digitaldefiance/node-ecies-lib`, I want to pass `IConstants` from `createRuntimeConfiguration` directly to `ECIESService`, so that the TypeScript compiler accepts the documented usage pattern without requiring type assertions.

#### Acceptance Criteria

1. WHEN the ECIESService constructor is called with an `IConstants` object, THEN the TypeScript compiler SHALL accept it without errors
2. WHEN the ECIESService constructor is called with `Partial<IECIESConfig>`, THEN the TypeScript compiler SHALL continue to accept it for backward compatibility
3. WHEN the ECIESService constructor signature is updated, THEN all existing usage patterns SHALL remain valid
4. THE ECIESService constructor SHALL import `IConstants` from the correct module path

### Requirement 3: Maintain Cross-Platform Consistency

**User Story:** As a developer working with both browser and Node.js environments, I want the ECIESService constructor signature to be identical in both libraries, so that I can write portable code without platform-specific type handling.

#### Acceptance Criteria

1. WHEN comparing the browser and Node.js ECIESService constructor signatures, THEN they SHALL be identical
2. WHEN code is written for one platform, THEN it SHALL compile without modification on the other platform
3. THE browser library (`ecies-lib`) and Node.js library (`node-ecies-lib`) SHALL accept the same parameter types

### Requirement 4: Validate Documented Usage Pattern

**User Story:** As a developer following the README documentation, I want the documented code examples to compile without errors, so that I can trust the documentation and get started quickly.

#### Acceptance Criteria

1. WHEN the documented example code is compiled, THEN it SHALL produce no TypeScript errors
2. WHEN `createRuntimeConfiguration` returns an `IConstants` object, THEN passing it to `new ECIESService(config)` SHALL be type-safe
3. THE following documented pattern SHALL compile successfully:
   ```typescript
   const config = createRuntimeConfiguration({ idProvider: new GuidV4Provider() });
   const ecies = new ECIESService(config);
   ```

### Requirement 5: Preserve Backward Compatibility

**User Story:** As a developer with existing code using `ECIESService`, I want my current code to continue working after the fix, so that I don't need to refactor my application.

#### Acceptance Criteria

1. WHEN existing code passes `Partial<IECIESConfig>` to the constructor, THEN it SHALL continue to work without modification
2. WHEN existing code passes `IECIESConstants` as the second parameter, THEN it SHALL continue to work without modification
3. WHEN the signature is updated, THEN no breaking changes SHALL be introduced to the public API
4. THE constructor SHALL support both old and new usage patterns simultaneously
