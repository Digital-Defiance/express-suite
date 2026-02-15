# Implementation Plan: Let's Encrypt Greenlock Support

## Overview

Incrementally add Let's Encrypt support via greenlock-express to the node-express-suite package. Each task builds on the previous, starting with the data model/config layer, then the Greenlock manager, then Application integration, and finally documentation. Tests are wired in alongside each component.

## Tasks

- [x] 1. Add `ILetsEncryptConfig` interface and extend `IEnvironment`
  - [x] 1.1 Create `ILetsEncryptConfig` interface in `src/interfaces/environment.ts` with `enabled`, `maintainerEmail`, `hostnames`, `staging`, and `configDir` fields
    - Add the `letsEncrypt: ILetsEncryptConfig` field to the `IEnvironment` interface
    - _Requirements: 1.1_
  - [x] 1.2 Add hostname validation utility function in `src/utils.ts`
    - Implement `isValidHostname(hostname: string): boolean` that accepts FQDNs and `*.domain.tld` wildcard patterns
    - Implement `parseHostnames(raw: string): string[]` that splits on commas, trims, and filters empty strings
    - _Requirements: 1.4, 5.3_
  - [x] 1.3 Write property tests for hostname validation and parsing
    - **Property 6: Hostname validation correctness**
    - **Validates: Requirements 5.3**
    - **Property 2: Hostname list parsing round-trip**
    - **Validates: Requirements 1.4**

- [x] 2. Update `Environment` class to parse Let's Encrypt env vars
  - [x] 2.1 Add Let's Encrypt env var parsing in the `Environment` constructor
    - Parse `LETS_ENCRYPT_ENABLED`, `LETS_ENCRYPT_EMAIL`, `LETS_ENCRYPT_HOSTNAMES`, `LETS_ENCRYPT_STAGING`, `LETS_ENCRYPT_CONFIG_DIR`
    - Apply defaults: `enabled=false`, `staging=false`, `configDir='./greenlock.d'`
    - _Requirements: 1.2, 1.4, 1.5, 1.6_
  - [x] 2.2 Add validation logic for Let's Encrypt config in the `Environment` constructor
    - When `enabled` is `true`, throw if `maintainerEmail` is missing/empty
    - When `enabled` is `true`, throw if `hostnames` is missing/empty
    - Validate each hostname using `isValidHostname()`
    - _Requirements: 1.3, 1.7, 1.8, 5.3_
  - [x] 2.3 Add `letsEncrypt` getter to the `Environment` class
    - Expose the `ILetsEncryptConfig` object via a public getter
    - _Requirements: 1.1_
  - [x] 2.4 Write property tests for Environment Let's Encrypt parsing
    - **Property 1: Boolean environment variable parsing**
    - **Validates: Requirements 1.2, 1.5**
    - **Property 3: Config directory default behavior**
    - **Validates: Requirements 1.6**
  - [x] 2.5 Write unit tests for Environment validation edge cases
    - Test: enabled=true with missing email throws
    - Test: enabled=true with missing hostnames throws
    - Test: enabled=true with invalid hostname throws
    - Test: enabled=false skips validation and uses defaults
    - _Requirements: 1.3, 1.7, 1.8_

- [x] 3. Checkpoint - Ensure all tests pass
  - Ensure all tests pass, ask the user if questions arise.

- [x] 4. Implement `GreenlockManager` class
  - [x] 4.1 Add `greenlock-express` dependency to `package.json`
    - Add `greenlock-express` to dependencies
    - _Requirements: 2.1_
  - [x] 4.2 Create `src/greenlock-manager.ts` with the `GreenlockManager` class
    - Implement constructor accepting `ILetsEncryptConfig`
    - Implement `start(expressApp)` that initializes greenlock-express, starts HTTPS on 443 and HTTP redirect on 80
    - Implement `stop()` that gracefully shuts down both servers
    - Handle wildcard hostnames by configuring DNS-01 challenge type
    - _Requirements: 2.1, 2.2, 3.1, 3.2, 3.3, 5.1, 5.2_
  - [x] 4.3 Write property test for HTTP redirect behavior
    - **Property 4: HTTP-to-HTTPS redirect correctness**
    - **Validates: Requirements 3.2**
  - [x] 4.4 Write property test for wildcard challenge type
    - **Property 5: Wildcard hostname triggers DNS-01 challenge**
    - **Validates: Requirements 5.2**
  - [x] 4.5 Write unit tests for GreenlockManager
    - Test: start() calls greenlock-express.init() with correct config
    - Test: stop() closes both servers
    - Test: graceful degradation when greenlock init fails
    - _Requirements: 2.1, 3.4, 4.2_

- [x] 5. Integrate GreenlockManager into Application class
  - [x] 5.1 Update `Application.start()` to use `GreenlockManager` when Let's Encrypt is enabled
    - Add `private greenlockManager: GreenlockManager | null = null` field
    - When `letsEncrypt.enabled` is true: create GreenlockManager, call start(), skip dev HTTPS block
    - When `letsEncrypt.enabled` is false: retain existing behavior unchanged
    - Still start primary HTTP server on `environment.port` regardless
    - _Requirements: 2.1, 2.2, 2.3, 2.4, 4.1, 4.3_
  - [x] 5.2 Update `Application.stop()` to shut down GreenlockManager
    - Call `greenlockManager.stop()` before existing shutdown logic
    - _Requirements: 3.4, 4.2_
  - [x] 5.3 Write unit tests for Application Let's Encrypt integration
    - Test: letsEncrypt enabled starts GreenlockManager and skips dev HTTPS
    - Test: letsEncrypt disabled preserves existing behavior
    - Test: stop() calls greenlockManager.stop()
    - Test: ready state is set only after all servers are listening
    - _Requirements: 2.3, 2.4, 4.1, 4.2, 4.3_

- [x] 6. Checkpoint - Ensure all tests pass
  - Ensure all tests pass, ask the user if questions arise.

- [x] 7. Update documentation
  - [x] 7.1 Add Let's Encrypt section to the package README
    - Document all environment variables: `LETS_ENCRYPT_ENABLED`, `LETS_ENCRYPT_EMAIL`, `LETS_ENCRYPT_HOSTNAMES`, `LETS_ENCRYPT_STAGING`, `LETS_ENCRYPT_CONFIG_DIR`
    - Provide example `.env` for single hostname
    - Provide example `.env` for multiple hostnames with wildcard
    - Explain port 80/443 requirements and permissions
    - Clarify mutual exclusivity with dev-certificate HTTPS mode
    - _Requirements: 6.1, 6.2, 6.3, 6.4, 6.5_

- [x] 8. Final checkpoint - Ensure all tests pass
  - Ensure all tests pass, ask the user if questions arise.

## Notes

- Tasks marked with `*` are optional and can be skipped for faster MVP
- Each task references specific requirements for traceability
- Checkpoints ensure incremental validation
- Property tests validate universal correctness properties using `fast-check`
- Unit tests validate specific examples and edge cases
- The `greenlock-express` library does not ship TypeScript types; the GreenlockManager encapsulates all untyped interactions
