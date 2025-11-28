# [Express Suite](https://github.com/Digital-Defiance/express-suite)

Express Suite is a comprehensive TypeScript monorepo designed to provide a robust foundation for building secure, scalable, and internationalized web applications. It integrates cryptographic services, internationalization (i18n), and Express.js framework components, all structured as modular packages to support modern development workflows.

Formerly known as Project Albatross, the suite draws inspiration from the great albatross bird, symbolizing endurance and the ability to traverse vast distances—qualities reflected in the suite's goal to deliver far-reaching, reliable solutions.

## Overview of Packages

Express Suite is composed of multiple interrelated packages, each serving a specific domain. The packages are designed to work together seamlessly, with clear dependency relationships and integration points.

### Package Dependency Graph

```
┌─────────────────────────────────────────────────────────────┐
│                    Application Layer                         │
│  express-suite-starter (Generator)                          │
│  express-suite-example (Reference Implementation)           │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    Presentation Layer                        │
│  express-suite-react-components                             │
│  (Auth forms, hooks, providers, UI components)              │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    Application Layer                         │
│  node-express-suite                                         │
│  (Express framework, auth, RBAC, MongoDB)                   │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    Business Logic Layer                      │
│  suite-core-lib                                             │
│  (User management, RBAC, crypto operations)                 │
└─────────────────────────────────────────────────────────────┘
                              │
                    ┌─────────┴─────────┐
                    ▼                   ▼
┌──────────────────────────┐  ┌──────────────────────────┐
│   Cryptography Layer     │  │  Internationalization    │
│  ecies-lib (Browser)     │  │  i18n-lib                │
│  node-ecies-lib (Node)   │  │                          │
└──────────────────────────┘  └──────────────────────────┘
                    │
                    ▼
┌─────────────────────────────────────────────────────────────┐
│                    Testing Layer                             │
│  express-suite-test-utils                                   │
│  (Test helpers, mocks, utilities)                           │
└─────────────────────────────────────────────────────────────┘
```

### Package Descriptions

### [@digitaldefiance/i18n-lib [NPM]](https://www.npmjs.com/package/@digitaldefiance/i18n-lib) [[GitHub]](https://github.com/Digital-Defiance/i18n-lib)

A production-ready TypeScript internationalization library with component-based architecture, type-safe translations, and comprehensive error handling. Features include:

- Production-grade security with protections against prototype pollution, ReDoS, and XSS
- Industry-standard ICU MessageFormat support with pluralization, gender, and advanced number/date/time formatting
- Component registration with full type safety and alias support
- Support for 37 languages with CLDR-compliant plural rules and 8 built-in languages
- Advanced template processing with component references, aliases, enums, and context variables (currency, timezone, language)
- Multiple isolated engine instances for different application contexts
- Fluent builder pattern for clean engine configuration
- Comprehensive error classes with translation support
- 93%+ test coverage with 1,700+ tests ensuring reliability and security
- Full TypeScript support with generic types
- Browser and Node.js support (Node 18+)

This library is ideal for scalable multilingual applications requiring robust internationalization and security.

### [@digitaldefiance/ecies-lib [NPM]](https://www.npmjs.com/package/@digitaldefiance/ecies-lib) [[GitHub]](https://github.com/Digital-Defiance/ecies-lib)

A production-ready, browser-compatible ECIES (Elliptic Curve Integrated Encryption Scheme) library for TypeScript. Built on Web Crypto API and @noble/curves, it offers comprehensive encryption, key management, and authentication services. Features include:

- Advanced ECIES v4.0 protocol with HKDF key derivation, AAD binding, and multi-recipient encryption
- Pluggable ID provider system supporting ObjectId, GUID, UUID, and custom formats
- Key management with BIP39 mnemonics and HD wallets
- Memory-efficient streaming encryption for large files
- Internationalization with automatic error translation in 8 languages
- Cross-platform compatibility with Node.js 18+ and modern browsers
- High test coverage with 1200+ passing tests

Ideal for secure client-side and cross-platform cryptographic operations.

### [@digitaldefiance/node-ecies-lib [NPM]](https://www.npmjs.com/package/@digitaldefiance/node-ecies-lib) [[GitHub]](https://github.com/Digital-Defiance/node-ecies-lib)

Node.js implementation of ECIES with binary compatibility to the browser ecies-lib, enabling cross-platform cryptographic operations. Includes Node.js crypto primitives, multi-recipient encryption, PBKDF2 profiles, and a flexible service container architecture. Perfect for backend services requiring secure encryption and key management.

### [@digitaldefiance/suite-core-lib [NPM]](https://www.npmjs.com/package/@digitaldefiance/suite-core-lib) [[GitHub]](https://github.com/Digital-Defiance/suite-core-lib)

A comprehensive library providing higher-level primitives and foundational building blocks for creating cryptographically-secure user management systems and Node.js Express server frameworks. Built on top of `@digitaldefiance/ecies-lib` and `@digitaldefiance/node-ecies-lib`, it powers the full-stack security ecosystem. Key features include:

- Secure user accounts and authentication with zero-knowledge proof flows
- Role-based access control (RBAC) with fine-grained permissions
- Multi-language internationalization with plugin-based architecture
- Type-safe interfaces for frontend and backend user models
- Cryptographically secure backup code generation and management
- Localized error handling in multiple languages
- Fluent builder APIs for user and role creation
- Dynamic model registration for extensibility
- Integration with Express.js framework and frontend adapters
- Extensive testing with high coverage and reliability
- Library of common internationalized strings for use in a typical application

### [@digitaldefiance/node-express-suite [NPM]](https://www.npmjs.com/package/@digitaldefiance/node-express-suite) [[GitHub]](https://github.com/Digital-Defiance/node-express-suite)

A complete Express.js framework integrating authentication, RBAC, MongoDB with Mongoose, and a dynamic model registry. Features JWT authentication, email tokens, ECIES integration, i18n middleware, and a service container. Designed for rapid development of secure, internationalized REST APIs with modern best practices.

### [@digitaldefiance/express-suite-starter [NPM]](https://www.npmjs.com/package/@digitaldefiance/express-suite-starter) [[GitHub]](https://github.com/Digital-Defiance/express-suite-starter)

An automated generator for MERN stack monorepos using Nx, React 19, Express 5, and MongoDB. Includes an interactive CLI, DevContainer options, Mustache templates, a plugin system, and rollback support. Simplifies project scaffolding and accelerates development with a modern, extensible starter kit.

### [@digitaldefiance/express-suite-test-utils [NPM]](https://www.npmjs.com/package/@digitaldefiance/express-suite-test-utils) [[GitHub]](https://github.com/Digital-Defiance/express-suite-test-utils)

A collection of test utilities to facilitate testing across the suite, including helpers for throwing types, console mocks, localStorage mocks, BSON mocks, React mocks, and in-memory MongoDB. Provides package-specific test helpers via `/testing` entry points for seamless integration. All testing utilities require `@faker-js/faker` as a dev dependency.

### [@digitaldefiance/express-suite-react-components [NPM]](https://www.npmjs.com/package/@digitaldefiance/express-suite-react-components) [[GitHub]](https://github.com/Digital-Defiance/express-suite-react-components)

Production-ready React components for authentication, user management, and internationalization. Includes auth forms (login, register, backup codes), route guards (PrivateRoute, UnAuthRoute), hooks (useAuth, useI18n), providers (AuthProvider, I18nProvider), and UI components (TopMenu, DashboardPage, ApiAccess). Pre-configured wrappers enable easy integration into React applications.

### [@digitaldefiance/express-suite-example [GitHub]](https://github.com/Digital-Defiance/express-suite-example)

A complete reference implementation demonstrating how to integrate Express Suite in a production MERN stack. Serves as a learning resource, starter template, and best practices reference for building secure, scalable, and internationalized web applications.

## Key Features

- **🔐 End-to-End Encryption**: Secure ECIES encryption using secp256k1 and AES-256-GCM, ensuring data confidentiality.
- **🌍 Internationalization**: Supports 8 languages with a flexible plugin architecture for easy localization.
- **🔑 Key Management**: Implements BIP39 mnemonics, HD wallets, and secure storage for cryptographic keys.
- **👥 User Management**: Role-based access control, JWT authentication, email verification, and backup codes.
- **📊 Database Integration**: MongoDB with Mongoose and a dynamic model registry for flexible data modeling.
- **🧪 Extensive Testing**: Over 2000 tests across all packages ensuring reliability and robustness.
- **🏗️ Modern Architecture**: Utilizes service containers, builders, fluent APIs, and plugin systems for extensibility.
- **⚡ Developer Experience**: Interactive CLI tools, DevContainer support, and automated monorepo scaffolding.
- **🔄 Seamless Integration**: Cross-platform cryptography libraries compatible between browser and Node.js environments.

## Cross-Package Integration

### Binary Compatibility: ecies-lib ↔ node-ecies-lib

The browser-based `ecies-lib` and Node.js `node-ecies-lib` maintain **binary compatibility**, enabling seamless encryption/decryption across platforms:

```typescript
// Browser (ecies-lib)
import { ECIESService } from '@digitaldefiance/ecies-lib';
const browserEcies = new ECIESService();
const encrypted = await browserEcies.encryptSimpleOrSingle(false, publicKey, data);

// Node.js (node-ecies-lib) - can decrypt the same data
import { ECIESService } from '@digitaldefiance/node-ecies-lib';
const nodeEcies = new ECIESService();
const decrypted = await nodeEcies.decryptSimpleOrSingleWithHeader(false, privateKey, encrypted);
```

**Key Compatibility Features:**
- Identical ECIES v4.0 protocol implementation
- Same message format and header structure
- Compatible ID provider systems (ObjectId, GUID, UUID, Custom)
- Shared encryption modes (Simple, Single, Multiple)

### suite-core-lib Integration

`suite-core-lib` builds on the ECIES libraries to provide higher-level user management primitives:

```typescript
import { UserBuilder, RoleBuilder } from '@digitaldefiance/suite-core-lib';
import { ECIESService } from '@digitaldefiance/node-ecies-lib';

// Create user with encrypted data
const ecies = new ECIESService();
const user = new UserBuilder()
  .withUsername('alice')
  .withEmail('alice@example.com')
  .withEncryptionService(ecies)
  .build();

// User operations automatically use ECIES for sensitive data
await user.encryptSensitiveData(data);
```

### node-express-suite Integration

`node-express-suite` integrates all backend packages into a complete Express.js framework:

```typescript
import { ExpressSuiteApp } from '@digitaldefiance/node-express-suite';
import { ECIESService } from '@digitaldefiance/node-ecies-lib';
import { I18nEngine } from '@digitaldefiance/i18n-lib';

// Initialize with all services
const app = new ExpressSuiteApp({
  ecies: new ECIESService(),
  i18n: I18nEngine.createInstance('app', languages),
  mongodb: { uri: process.env.MONGODB_URI },
  jwt: { secret: process.env.JWT_SECRET }
});

// Framework automatically handles:
// - JWT authentication with encrypted tokens
// - RBAC with encrypted permissions
// - i18n middleware for all responses
// - MongoDB with encrypted sensitive fields
```

### express-suite-react-components Integration

React components integrate with backend APIs using shared types and interfaces:

```typescript
import { AuthProvider, useAuth } from '@digitaldefiance/express-suite-react-components';
import { LoginForm, RegisterForm } from '@digitaldefiance/express-suite-react-components';

function App() {
  return (
    <AuthProvider apiUrl="https://api.example.com">
      <LoginForm 
        onSuccess={(user) => console.log('Logged in:', user)}
        i18nLanguage="en-US"
      />
    </AuthProvider>
  );
}

// Components automatically:
// - Use suite-core-lib types for type safety
// - Handle i18n with i18n-lib integration
// - Encrypt sensitive data with ecies-lib
// - Communicate with node-express-suite APIs
```

### Testing Integration

`express-suite-test-utils` provides helpers for testing across all packages:

```typescript
import { 
  withConsoleMocks,
  connectMemoryDB,
  mockBackendMember 
} from '@digitaldefiance/express-suite-test-utils';
import { mockFrontendMember } from '@digitaldefiance/ecies-lib/testing';

describe('Cross-package integration', () => {
  beforeAll(async () => {
    await connectMemoryDB(); // In-memory MongoDB
  });

  it('should encrypt data cross-platform', async () => {
    const browserMember = mockFrontendMember();
    const nodeMember = mockBackendMember();
    
    // Encrypt in browser
    const encrypted = await browserMember.encryptData('secret');
    
    // Decrypt in Node.js
    const decrypted = await nodeMember.decryptData(encrypted);
    expect(decrypted).toBe('secret');
  });
});
```

## API Quick Reference

### Core Exports by Package

#### @digitaldefiance/i18n-lib

**Main Classes:**
- `PluginI18nEngine` - Main i18n engine with component-based architecture
- `I18nBuilder` - Fluent builder for engine configuration
- `GlobalActiveContext` - Global context for currency, timezone, language

**Functions:**
- `formatICUMessage(message, variables, locale)` - Format ICU MessageFormat strings
- `getCoreI18nEngine()` - Get core engine with system strings
- `createPluralString(forms)` - Create type-safe plural strings
- `createGenderedString(forms)` - Create type-safe gendered strings

**Types & Enums:**
- `LanguageCodes` - BCP 47 language codes (EN_US, FR, ES, DE, ZH_CN, JA, UK)
- `ComponentRegistration` - Type-safe component registration
- `LanguageDefinition` - Language configuration interface

#### @digitaldefiance/ecies-lib

**Main Classes:**
- `ECIESService` - Main encryption/decryption service
- `Member` - High-level user abstraction with crypto operations
- `SecureString` / `SecureBuffer` - Memory-safe sensitive data storage
- `ObjectIdProvider` / `GuidV4Provider` / `UuidProvider` - ID provider implementations

**Functions:**
- `createRuntimeConfiguration(overrides)` - Create custom configuration
- `getEciesI18nEngine()` - Get ECIES i18n engine

**Constants:**
- `Constants` - Default immutable configuration
- `ECIES` - ECIES-specific constants
- `PBKDF2_PROFILES` - Password hashing profiles

#### @digitaldefiance/node-ecies-lib

**Main Classes:**
- `ECIESService` - Node.js ECIES implementation (binary compatible with ecies-lib)
- `Member` - Backend member implementation
- `PasswordLoginService` - Secure authentication service

**Functions:**
- `createRuntimeConfiguration(overrides)` - Create custom Node.js configuration

#### @digitaldefiance/suite-core-lib

**Main Classes:**
- `UserBuilder` - Fluent builder for user creation
- `RoleBuilder` - Fluent builder for role creation
- `PermissionManager` - RBAC permission management

**Functions:**
- `generateBackupCodes(count)` - Generate cryptographically secure backup codes
- `validateBackupCode(code, hash)` - Validate backup code against hash

**Types:**
- `IUser` - User interface (shared between frontend/backend)
- `IRole` - Role interface with permissions
- `IPermission` - Permission interface

#### @digitaldefiance/node-express-suite

**Main Classes:**
- `ExpressSuiteApp` - Main application class integrating all services
- `AuthMiddleware` - JWT authentication middleware
- `RBACMiddleware` - Role-based access control middleware
- `I18nMiddleware` - Internationalization middleware
- `ModelRegistry` - Dynamic Mongoose model registration

**Functions:**
- `createExpressApp(config)` - Create configured Express application
- `setupAuth(app, config)` - Setup authentication routes
- `setupRBAC(app, config)` - Setup RBAC middleware

#### @digitaldefiance/express-suite-react-components

**Components:**
- `<AuthProvider>` - Authentication context provider
- `<LoginForm>` - Pre-built login form with validation
- `<RegisterForm>` - Pre-built registration form
- `<PrivateRoute>` - Protected route component
- `<TopMenu>` - Navigation menu with auth state

**Hooks:**
- `useAuth()` - Access authentication state and methods
- `useI18n()` - Access i18n translation functions
- `usePermissions()` - Check user permissions

#### @digitaldefiance/express-suite-test-utils

**Functions:**
- `withConsoleMocks(options, callback)` - Mock console methods
- `connectMemoryDB()` - Connect to in-memory MongoDB
- `disconnectMemoryDB()` - Disconnect from in-memory MongoDB
- `clearMemoryDB()` - Clear all data from in-memory MongoDB

**Matchers:**
- `expect().toThrowType(ErrorClass, validator?)` - Custom Jest matcher for error types

### Common Usage Patterns

#### Setting up i18n

```typescript
import { PluginI18nEngine, LanguageCodes } from '@digitaldefiance/i18n-lib';

const engine = PluginI18nEngine.createInstance('app', [
  { id: LanguageCodes.EN_US, name: 'English', code: 'en-US', isDefault: true },
  { id: LanguageCodes.FR, name: 'Français', code: 'fr' }
]);

engine.registerComponent({
  component: { id: 'app', name: 'App', stringKeys: ['welcome'] },
  strings: {
    [LanguageCodes.EN_US]: { welcome: 'Welcome!' },
    [LanguageCodes.FR]: { welcome: 'Bienvenue!' }
  }
});
```

#### Encrypting Data (Browser)

```typescript
import { ECIESService } from '@digitaldefiance/ecies-lib';

const ecies = new ECIESService();
const mnemonic = ecies.generateNewMnemonic();
const { privateKey, publicKey } = ecies.mnemonicToSimpleKeyPair(mnemonic);

const data = new TextEncoder().encode('Secret message');
const encrypted = await ecies.encryptSimpleOrSingle(false, publicKey, data);
const decrypted = await ecies.decryptSimpleOrSingleWithHeader(false, privateKey, encrypted);
```

#### Creating Users with RBAC

```typescript
import { UserBuilder, RoleBuilder } from '@digitaldefiance/suite-core-lib';

const adminRole = new RoleBuilder()
  .withName('admin')
  .withPermissions(['users:read', 'users:write', 'users:delete'])
  .build();

const user = new UserBuilder()
  .withUsername('alice')
  .withEmail('alice@example.com')
  .withRoles([adminRole])
  .build();
```

#### Setting up Express Backend

```typescript
import { ExpressSuiteApp } from '@digitaldefiance/node-express-suite';

const app = new ExpressSuiteApp({
  mongodb: { uri: process.env.MONGODB_URI },
  jwt: { secret: process.env.JWT_SECRET },
  i18n: { defaultLanguage: 'en-US' }
});

await app.start(3000);
```

#### React Authentication

```typescript
import { AuthProvider, LoginForm, useAuth } from '@digitaldefiance/express-suite-react-components';

function App() {
  return (
    <AuthProvider apiUrl="https://api.example.com">
      <LoginForm onSuccess={(user) => console.log('Logged in:', user)} />
    </AuthProvider>
  );
}

function Dashboard() {
  const { user, logout } = useAuth();
  return <div>Welcome {user.username}! <button onClick={logout}>Logout</button></div>;
}
```

## Development and Contribution

### Cloning the Repository

```bash
git clone --recursive https://github.com/Digital-Defiance/express-suite.git
# Or if already cloned
git submodule update --init --recursive
```

### Working with Submodules

```bash
git submodule update --remote --merge
git pull --recurse-submodules
git submodule status
```

### Building and Testing

```bash
yarn install
yarn build
yarn test
```

### Running Specific Package Commands

```bash
# Build a specific package
yarn nx build digitaldefiance-i18n-lib

# Test a specific package
yarn nx test digitaldefiance-ecies-lib

# Lint all packages
yarn nx run-many --target=lint --all
```

## Architecture Overview

```
express-suite/
├── digitaldefiance-i18n-lib/                      # Internationalization library
├── digitaldefiance-ecies-lib/                     # Browser ECIES cryptography
├── digitaldefiance-node-ecies-lib/                # Node.js ECIES cryptography
├── digitaldefiance-suite-core-lib/                # Core user management primitives
├── digitaldefiance-node-express-suite/            # Express.js framework with auth and DB
├── digitaldefiance-express-suite-starter/         # Monorepo generator CLI
├── digitaldefiance-express-suite-test-utils/      # Test utilities
├── digitaldefiance-express-suite-react-components/ # React UI components
└── digitaldefiance-express-suite-example/         # Example MERN stack implementation
```

## License

MIT © Digital Defiance, Jessica Mulein
