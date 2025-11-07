# Express Suite

A comprehensive TypeScript monorepo providing cryptographic services, internationalization, and Express.js framework components for building secure applications.

## Packages

### [@digitaldefiance/i18n-lib](packages/digitaldefiance-i18n-lib)
Production-ready internationalization library with component-based architecture, type-safe translations, and 8 built-in languages.

**Features**: Plugin architecture, template processing, context variables, error translation, 91.81% test coverage

### [@digitaldefiance/ecies-lib](packages/digitaldefiance-ecies-lib)
Browser-compatible ECIES encryption library with comprehensive key management and authentication services.

**Features**: ECIES encryption (Simple/Single/Multiple modes), BIP39 mnemonics, HD wallets, file encryption, password login, 393 tests

### [@digitaldefiance/node-ecies-lib](packages/digitaldefiance-node-ecies-lib)
Node.js ECIES implementation with binary compatibility to ecies-lib for cross-platform cryptographic operations.

**Features**: Node.js crypto primitives, multi-recipient encryption, PBKDF2 profiles, service container, 220 tests

### [@digitaldefiance/suite-core-lib](packages/digitaldefiance-suite-core-lib)
Core primitives for cryptographically-secure user management systems with RBAC and multi-language support.

**Features**: User interfaces, backup codes, account management, role system, 409 tests, 98.47% coverage

### [@digitaldefiance/node-express-suite](packages/digitaldefiance-node-express-suite)
Complete Express.js framework with authentication, RBAC, MongoDB integration, and dynamic model registry.

**Features**: JWT auth, email tokens, ECIES integration, i18n middleware, 604 tests, service container

### [@digitaldefiance/express-suite-test-utils](packages/digitaldefiance-express-suite-test-utils)
Handy test utilities (toThrowType, withConsoleMocks) and more in the near future

## Development/Contribution Quick Start

### Clone with Submodules

```bash
# Clone with all submodules
git clone --recursive https://github.com/Digital-Defiance/express-suite.git

# Or if already cloned, initialize submodules
git submodule update --init --recursive
```

### Working with Submodules

```bash
# Update all submodules to latest
git submodule update --remote --merge

# Pull changes including submodules
git pull --recurse-submodules

# Check submodule status
git submodule status
```

### Build and Test

```bash
# Install dependencies
yarn install

# Build all packages
yarn build

# Run tests
yarn test
```

## Architecture

```
express-suite/
├── digitaldefiance-i18n-lib/          # Internationalization
├── digitaldefiance-ecies-lib/         # Browser crypto
├── digitaldefiance-node-ecies-lib/    # Node.js crypto
├── digitaldefiance-suite-core-lib/    # User management primitives
└── digitaldefiance-node-express-suite/ # Express.js framework
```

## Key Features

- **🔐 End-to-End Encryption**: ECIES with secp256k1, AES-256-GCM
- **🌍 Internationalization**: 8 languages with plugin architecture
- **🔑 Key Management**: BIP39 mnemonics, HD wallets, secure storage
- **👥 User Management**: RBAC, JWT auth, email verification
- **📊 Database**: MongoDB with Mongoose, dynamic model registry
- **🧪 Testing**: 2000+ tests across all packages
- **🏗️ Modern Architecture**: Service containers, builders, fluent APIs

## Development

```bash
# Build specific package
yarn nx build digitaldefiance-i18n-lib

# Test specific package
yarn nx test digitaldefiance-ecies-lib

# Lint all
yarn nx run-many --target=lint --all
```

As always, see [package.json](./package.json)

## License

MIT © Digital Defiance, Jessica Mulein

## ChangeLog

### v2.1.27

- Added new express-suite-test-utils dependency

### v2.1.25

**Comprehensive Quality & Stability Release** - Major improvements across all packages with enhanced testing, coverage, and type safety.

#### All Packages
- **UPGRADED**: All inter-package dependencies to v2.1.25 for consistency
- **IMPROVED**: Test coverage and reliability across the suite
- **FIXED**: i18n aliasing and component registration issues
- **ENHANCED**: Type safety and error handling throughout

#### @digitaldefiance/i18n-lib
- **IMPROVED**: Test coverage to 91.81% (714 tests passing)
- **ADDED**: `registerIfNotExists()` methods for safe component registration
- **ADDED**: Constants management with `updateConstants()` and `mergeConstants()`
- **FIXED**: Component alias resolution in `t()` function
- **ENHANCED**: Context variable injection with CurrencyCode and Timezone support

#### @digitaldefiance/ecies-lib
- **IMPROVED**: Test suite with 393 tests (100% passing)
- **ADDED**: Frontend member mock for testing
- **UPGRADED**: i18n integration with automatic engine retrieval
- **ENHANCED**: Error translation in 8 languages
- **FIXED**: PBKDF2 profile lookup and validation

#### @digitaldefiance/node-ecies-lib
- **IMPROVED**: 220/220 tests passing (100% success rate)
- **ADDED**: Backend member mock for testing
- **MAINTAINED**: 100% binary compatibility with browser ecies-lib
- **ENHANCED**: Service container and builder patterns
- **FIXED**: Constructor signatures for simplified API

#### @digitaldefiance/suite-core-lib
- **MAINTAINED**: 409 tests with 98.47% statement coverage
- **ADDED**: Additional string keys for internationalization
- **UPGRADED**: Dependencies (i18n-lib, ecies-lib)
- **ENHANCED**: Validation builders with custom constants support
- **FIXED**: Translation key processing and template handling

#### @digitaldefiance/node-express-suite
- **IMPROVED**: 604 tests passing (100% success rate)
- **IMPROVED**: Code coverage to 57.86% (+4.51%)
- **ADDED**: Concrete ApplicationConcrete class for testing
- **ADDED**: DummyEmailService for test environments
- **ADDED**: Comprehensive mocks and fixtures
- **FIXED**: i18n initialization in database setup
- **FIXED**: Validation builder chain initialization
- **ENHANCED**: Clean test output with proper console mocking
- **STREAMLINED**: Application generics for better usability

#### Testing Highlights
- **2000+ tests** across all packages
- **100% pass rate** in all test suites
- **Enhanced coverage** in critical paths
- **Improved reliability** with proper initialization
- **Better mocking** for isolated unit tests

#### Developer Experience
- **Simplified APIs** with reduced generic complexity
- **Better type inference** throughout
- **Comprehensive mocks** for testing
- **Improved documentation** with examples
- **Consistent patterns** across packages

#### Migration Notes
- **Backward compatible** - No breaking changes
- **Drop-in replacement** for v2.1.x versions
- **Automatic upgrades** for inter-package dependencies
- **Safe to upgrade** with existing codebases
