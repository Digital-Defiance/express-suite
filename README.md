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
