# [Express Suite](https://github.com/Digital-Defiance/express-suite)

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
[![TypeScript](https://img.shields.io/badge/%3C%2F%3E-TypeScript-%230074c1.svg)](http://www.typescriptlang.org/)
[![Tests](https://img.shields.io/badge/tests-9%2C700%2B%20passing-brightgreen)](https://github.com/Digital-Defiance/express-suite)

**Express Suite** is a comprehensive TypeScript monorepo providing a complete foundation for building secure, scalable, and internationalized web applications. It integrates enterprise-grade cryptography, multi-language internationalization, and a full-stack MERN framework—all structured as modular packages for modern development workflows.

Formerly known as **Project Albatross**, the suite draws inspiration from the great albatross bird, symbolizing endurance and the ability to traverse vast distances—qualities reflected in the suite's goal to deliver far-reaching, reliable solutions.

## Key Highlights

- **🔐 End-to-End Encryption**: ECIES with secp256k1 and AES-256-GCM, binary-compatible across browser and Node.js
- **🗳️ Cryptographic Voting**: 17 voting methods with homomorphic encryption, threshold decryption, and government-grade audit trails
- **🌍 37-Language i18n**: ICU MessageFormat with CLDR-compliant plural rules and component-based architecture
- **👥 Complete User Management**: RBAC, JWT authentication, backup codes, and zero-knowledge auth flows
- **📊 MongoDB Integration**: Dynamic model registry with Mongoose and flexible ID providers
- **🧪 9,700+ Tests**: Comprehensive coverage ensuring reliability across all packages
- **⚡ Modern DX**: Interactive CLI generators, DevContainer support, and fluent builder APIs

---

## Package Overview

Express Suite consists of 10 interrelated packages, each serving a specific domain while maintaining seamless integration.

| Package | NPM | Tests | Description |
|---------|-----|-------|-------------|
| [i18n-lib](#digitaldefiancei18n-lib) | [![npm](https://img.shields.io/npm/v/@digitaldefiance/i18n-lib.svg)](https://www.npmjs.com/package/@digitaldefiance/i18n-lib) | 2,007 | Production-ready internationalization with ICU MessageFormat |
| [ecies-lib](#digitaldefianceecies-lib) | [![npm](https://img.shields.io/npm/v/@digitaldefiance/ecies-lib.svg)](https://www.npmjs.com/package/@digitaldefiance/ecies-lib) | 2,429 | Browser ECIES encryption with voting system |
| [node-ecies-lib](#digitaldefiancenode-ecies-lib) | [![npm](https://img.shields.io/npm/v/@digitaldefiance/node-ecies-lib.svg)](https://www.npmjs.com/package/@digitaldefiance/node-ecies-lib) | 1,953 | Node.js ECIES with binary compatibility |
| [suite-core-lib](#digitaldefiancesuite-core-lib) | [![npm](https://img.shields.io/npm/v/@digitaldefiance/suite-core-lib.svg)](https://www.npmjs.com/package/@digitaldefiance/suite-core-lib) | 512 | User management primitives and RBAC |
| [node-express-suite](#digitaldefiancenode-express-suite) | [![npm](https://img.shields.io/npm/v/@digitaldefiance/node-express-suite.svg)](https://www.npmjs.com/package/@digitaldefiance/node-express-suite) | 2,541 | Complete Express.js framework |
| [express-suite-starter](#digitaldefianceexpress-suite-starter) | [![npm](https://img.shields.io/npm/v/@digitaldefiance/express-suite-starter.svg)](https://www.npmjs.com/package/@digitaldefiance/express-suite-starter) | 96 | MERN stack monorepo generator |
| [express-suite-test-utils](#digitaldefianceexpress-suite-test-utils) | [![npm](https://img.shields.io/npm/v/@digitaldefiance/express-suite-test-utils.svg)](https://www.npmjs.com/package/@digitaldefiance/express-suite-test-utils) | — | Testing utilities and mocks |
| [express-suite-react-components](#digitaldefianceexpress-suite-react-components) | [![npm](https://img.shields.io/npm/v/@digitaldefiance/express-suite-react-components.svg)](https://www.npmjs.com/package/@digitaldefiance/express-suite-react-components) | 227 | React MUI components for auth and UI |
| [mongoose-types](#digitaldefiancemongoose-types) | [![npm](https://img.shields.io/npm/v/@digitaldefiance/mongoose-types.svg)](https://www.npmjs.com/package/@digitaldefiance/mongoose-types) | — | Flexible ID types for Mongoose 8.x |
| [express-suite-example](https://github.com/Digital-Defiance/express-suite-example) | — | — | Reference MERN implementation |


### Package Dependency Graph

```
┌─────────────────────────────────────────────────────────────┐
│                    Application Layer                        │
│  express-suite-starter (Generator)                          │
│  express-suite-example (Reference Implementation)           │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    Presentation Layer                       │
│  express-suite-react-components                             │
│  (Auth forms, hooks, providers, UI components)              │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    Application Layer                        │
│  node-express-suite                                         │
│  (Express framework, auth, RBAC, MongoDB)                   │
└─────────────────────────────────────────────────────────────┘
                              │
                              ▼
┌─────────────────────────────────────────────────────────────┐
│                    Business Logic Layer                     │
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
│                    Testing Layer                            │
│  express-suite-test-utils                                   │
│  (Test helpers, mocks, MongoDB memory server)               │
└─────────────────────────────────────────────────────────────┘
```

---

## @digitaldefiance/i18n-lib

**Production-ready TypeScript internationalization with component-based architecture, type-safe translations, and comprehensive security.**

[NPM](https://www.npmjs.com/package/@digitaldefiance/i18n-lib) · [GitHub](https://github.com/Digital-Defiance/express-suite/tree/main/packages/digitaldefiance-i18n-lib)

### Features at a Glance

- **ICU MessageFormat**: Industry-standard formatting with plural, select, date/time/number formatting
- **37 Languages**: CLDR-compliant plural rules from simple (Japanese) to complex (Arabic with 6 forms)
- **Component Architecture**: Register translation components with full type safety and aliases
- **Security Hardened**: Protection against prototype pollution, ReDoS, and XSS attacks
- **Multiple Instances**: Create isolated i18n engines for micro-frontends or multi-tenant apps
- **93%+ Test Coverage**: 2,007 tests ensuring reliability

### Quick Start

```typescript
import { PluginI18nEngine, LanguageCodes } from '@digitaldefiance/i18n-lib';

// Create engine with supported languages
const engine = PluginI18nEngine.createInstance('myapp', [
  { id: LanguageCodes.EN_US, name: 'English (US)', code: 'en-US', isDefault: true },
  { id: LanguageCodes.FR, name: 'Français', code: 'fr' }
]);

// Register component with translations
engine.registerComponent({
  component: { id: 'app', name: 'Application', stringKeys: ['welcome', 'items'] },
  strings: {
    [LanguageCodes.EN_US]: {
      welcome: 'Welcome to {appName}!',
      items: { one: '{count} item', other: '{count} items' }  // Pluralization
    },
    [LanguageCodes.FR]: {
      welcome: 'Bienvenue sur {appName}!',
      items: { one: '{count} article', other: '{count} articles' }
    }
  }
});

// Translate with variables
engine.translate('app', 'welcome', { appName: 'MyApp' });  // "Welcome to MyApp!"
engine.translate('app', 'items', { count: 5 });            // "5 items"

// Switch language
engine.setLanguage(LanguageCodes.FR);
engine.translate('app', 'welcome', { appName: 'MyApp' });  // "Bienvenue sur MyApp!"
```

### ICU MessageFormat

```typescript
import { formatICUMessage } from '@digitaldefiance/i18n-lib';

// Pluralization
formatICUMessage('{count, plural, one {# item} other {# items}}', { count: 1 });
// → "1 item"

// Gender selection
formatICUMessage('{gender, select, male {He} female {She} other {They}} liked this', { gender: 'female' });
// → "She liked this"

// Number formatting
formatICUMessage('{price, number, currency}', { price: 99.99 }, 'en-US');
// → "$99.99"

// Complex nested
formatICUMessage(
  '{gender, select, male {He has} female {She has} other {They have}} {count, plural, one {# item} other {# items}}',
  { gender: 'female', count: 3 }
);
// → "She has 3 items"
```

### Builder Pattern

```typescript
import { I18nBuilder } from '@digitaldefiance/i18n-lib';

const engine = I18nBuilder.create()
  .withLanguages([
    { id: 'en-US', name: 'English', code: 'en-US', isDefault: true },
    { id: 'fr', name: 'French', code: 'fr' }
  ])
  .withConstants({ AppName: 'MyApp', Version: '1.0.0' })
  .withInstanceKey('myapp')
  .build();
```

For a comprehensive guide on writing an `i18n-setup.ts` file that registers multiple components and branded enums across Express Suite packages, see the [Monorepo i18n-setup Guide](packages/digitaldefiance-i18n-lib/README.md#monorepo-i18n-setup-guide) in the i18n-lib README.

---

## @digitaldefiance/ecies-lib

**Production-ready, browser-compatible ECIES encryption with a complete cryptographic voting system supporting 17 voting methods.**

[NPM](https://www.npmjs.com/package/@digitaldefiance/ecies-lib) · [GitHub](https://github.com/Digital-Defiance/express-suite/tree/main/packages/digitaldefiance-ecies-lib)

### Features at a Glance

- **ECIES v4.0 Protocol**: HKDF-SHA256 key derivation, AAD binding, multi-recipient optimization
- **Cryptographic Voting**: 17 methods including IRV, STAR, STV with homomorphic encryption and threshold decryption
- **Pluggable ID Providers**: ObjectId, GUID, UUID, or custom formats (1-255 bytes)
- **Streaming Encryption**: Process gigabytes with <10MB memory footprint
- **BIP39/BIP32**: Mnemonic phrases and HD wallet derivation
- **8-Language i18n**: Automatic error translation
- **2,429 Tests**: Comprehensive coverage

### Quick Start

```typescript
import { ECIESService, getEciesI18nEngine } from '@digitaldefiance/ecies-lib';

// Initialize i18n (required once)
getEciesI18nEngine();

// Create service and generate keys
const ecies = new ECIESService();
const mnemonic = ecies.generateNewMnemonic();
const { privateKey, publicKey } = ecies.mnemonicToSimpleKeyPair(mnemonic);

// Encrypt and decrypt
const message = new TextEncoder().encode('Hello, Secure World!');
const encrypted = await ecies.encryptWithLength(publicKey, message);
const decrypted = await ecies.decryptWithLengthAndHeader(privateKey, encrypted);

console.log(new TextDecoder().decode(decrypted)); // "Hello, Secure World!"
```

### Cryptographic Voting System

The library includes a complete voting system with government-grade security:

```typescript
import { ECIESService, Member, MemberType, EmailString } from '@digitaldefiance/ecies-lib';
import { PollFactory, VoteEncoder, PollTallier } from '@digitaldefiance/ecies-lib/voting';

// Create election authority
const ecies = new ECIESService();
const { member: authority } = Member.newMember(ecies, MemberType.System, 'Authority', new EmailString('auth@example.com'));
await authority.deriveVotingKeys();

// Create poll with candidates
const poll = PollFactory.createPlurality(['Alice', 'Bob', 'Charlie'], authority);

// Voter casts encrypted vote
const { member: voter } = Member.newMember(ecies, MemberType.User, 'Voter', new EmailString('voter@example.com'));
await voter.deriveVotingKeys();

const encoder = new VoteEncoder(authority.votingPublicKey!);
const vote = encoder.encodePlurality(0, 3);  // Vote for Alice
const receipt = poll.vote(voter, vote);

// Close and tally
poll.close();
const tallier = new PollTallier(authority, authority.votingPrivateKey!, authority.votingPublicKey!);
const results = tallier.tally(poll);

console.log('Winner:', results.choices[results.winner!]);
```

**Supported Voting Methods:**
- **Single-Round**: Plurality, Approval, Weighted, Borda Count, Score, Yes/No, Supermajority
- **Multi-Round**: Ranked Choice (IRV), Two-Round, STAR, STV
- **Threshold Decryption**: Real-time interval tallies with k-of-n Guardian cooperation
- **Special**: Quadratic, Consensus, Consent-Based

### ID Provider System

```typescript
import { createRuntimeConfiguration, GuidV4Provider, ECIESService } from '@digitaldefiance/ecies-lib';

// Configure 16-byte GUIDs instead of default 12-byte ObjectIds
const config = createRuntimeConfiguration({ idProvider: new GuidV4Provider() });
const ecies = new ECIESService(config);

// All cryptographic operations now use GUID-sized IDs
const id = config.idProvider.generate();  // 16-byte Uint8Array
```

---

## @digitaldefiance/node-ecies-lib

**Node.js ECIES implementation with binary compatibility to the browser library, enabling seamless cross-platform cryptographic operations.**

[NPM](https://www.npmjs.com/package/@digitaldefiance/node-ecies-lib) · [GitHub](https://github.com/Digital-Defiance/express-suite/tree/main/packages/digitaldefiance-node-ecies-lib)

### Features at a Glance

- **Binary Compatible**: Data encrypted in browser can be decrypted in Node.js and vice versa
- **Node.js Optimized**: Uses Buffer instead of Uint8Array for better performance
- **Complete Voting System**: All 17 voting methods with Node.js optimizations and threshold decryption
- **Streaming Encryption**: Node.js Transform streams for large file processing
- **Strong Typing**: Enhanced ID provider system with compile-time type safety
- **1,953 Tests**: Comprehensive coverage

### Cross-Platform Encryption

```typescript
// Browser (ecies-lib)
import { ECIESService } from '@digitaldefiance/ecies-lib';
const browserEcies = new ECIESService();
const encrypted = await browserEcies.encryptWithLength(publicKey, data);

// Node.js (node-ecies-lib) - can decrypt the same data
import { ECIESService } from '@digitaldefiance/node-ecies-lib';
const nodeEcies = new ECIESService();
const decrypted = nodeEcies.decryptWithLengthAndHeader(privateKey, encrypted);
```

### Strong Typing for ID Providers

```typescript
import { getEnhancedNodeIdProvider, createNodeObjectIdConfiguration } from '@digitaldefiance/node-ecies-lib';
import { ObjectId } from 'bson';

// Enhanced provider with strongly-typed methods
const provider = getEnhancedNodeIdProvider<ObjectId>();
const objectId = provider.generateTyped();  // Returns ObjectId, not unknown!
const serialized = provider.serializeTyped(objectId);

// Or use configuration wrapper
const config = createNodeObjectIdConfiguration();
const id = config.generateId();  // Returns ObjectId directly
```

### Streaming Large Files

```typescript
import { ECIESService, EncryptionStream } from '@digitaldefiance/node-ecies-lib';
import { createReadStream } from 'fs';

const ecies = new ECIESService();
const stream = new EncryptionStream(ecies);

async function encryptFile(filePath: string, publicKey: Buffer) {
  const fileStream = createReadStream(filePath);
  for await (const chunk of stream.encryptStream(fileStream, publicKey)) {
    // Write chunk.data to output - memory efficient for any file size
  }
}
```


---

## @digitaldefiance/suite-core-lib

**Higher-level primitives for cryptographically-secure user management systems, providing the foundation for Express Suite's authentication and authorization.**

[NPM](https://www.npmjs.com/package/@digitaldefiance/suite-core-lib) · [GitHub](https://github.com/Digital-Defiance/express-suite/tree/main/packages/digitaldefiance-suite-core-lib)

### Features at a Glance

- **Type-Safe Base Interfaces**: Generic ID support for MongoDB ObjectId, UUID, or custom formats
- **Fluent Builders**: UserBuilder and RoleBuilder with chainable APIs
- **Secure Backup Codes**: Cryptographically secure generation and validation
- **Localized Errors**: Error classes with automatic translation in 5 languages
- **Result Pattern**: Type-safe error handling without exceptions
- **Validators**: Username, email, password validation with custom constants
- **512 Tests**: 98%+ statement coverage

### Type-Safe User Interfaces

```typescript
import { IUserBase, AccountStatus } from '@digitaldefiance/suite-core-lib';
import { Types } from 'mongoose';

// MongoDB backend with ObjectId
type BackendUser = IUserBase<Types.ObjectId, Date, 'en', AccountStatus>;

// Frontend with string IDs
type FrontendUser = IUserBase<string, string, 'en', AccountStatus>;

// SQL database with UUID strings
type SqlUser = IUserBase<string, Date, 'en', AccountStatus>;
```

### Fluent Builders

```typescript
import { UserBuilder, RoleBuilder, Role } from '@digitaldefiance/suite-core-lib';

// Build user with fluent API
const user = UserBuilder.create()
  .withUsername('alice')
  .withEmail('alice@example.com')
  .withEmailVerified(true)
  .build();

// Build role
const adminRole = RoleBuilder.create()
  .withName(Role.Admin)
  .asAdmin()
  .build();
```

### Secure Backup Codes

```typescript
import { BackupCodeString } from '@digitaldefiance/suite-core-lib';

// Generate cryptographically secure backup codes
const codes = BackupCodeString.generateBackupCodes();  // Default: 10 codes

// Format for user display
const code = new BackupCodeString('deadbeefcafebabefeedface01234567');
console.log(code.value);  // "dead-beef-cafe-babe-feed-face-0123-4567"

// Multiple encoding formats
console.log(code.valueAsHexString);     // Hex-encoded
console.log(code.valueAsBase64String);  // Base64-encoded
console.log(code.valueAsUint8Array);    // Raw bytes
```

### Localized Error Handling

```typescript
import { UserNotFoundError, UsernameInUseError, AccountLockedError } from '@digitaldefiance/suite-core-lib';
import { LanguageCodes } from '@digitaldefiance/i18n-lib';

throw new UserNotFoundError(LanguageCodes.FR);
// → "Compte utilisateur introuvable"

throw new UsernameInUseError(LanguageCodes.ES);
// → "El nombre de usuario ya está en uso"
```

### Validators with Custom Constants

```typescript
import { isValidUsername, isValidEmail, createValidators, createConstants } from '@digitaldefiance/suite-core-lib';

// Use default validators
if (!isValidUsername('alice123')) {
  throw new Error('Invalid username');
}

// Create validators with custom rules
const myConstants = createConstants('myapp.com', {
  UsernameRegex: /^[a-z0-9_]{4,20}$/,
  UsernameMinLength: 4,
  UsernameMaxLength: 20,
});
const validators = createValidators(myConstants);
validators.isValidUsername('user_name');
```

---

## @digitaldefiance/node-express-suite

**Complete Express.js framework integrating authentication, RBAC, MongoDB, and a dynamic model registry—the backend powerhouse of Express Suite.**

[NPM](https://www.npmjs.com/package/@digitaldefiance/node-express-suite) · [GitHub](https://github.com/Digital-Defiance/express-suite/tree/main/packages/digitaldefiance-node-express-suite)

### Features at a Glance

- **ECIES Integration**: End-to-end encryption with mnemonic authentication
- **JWT Authentication**: Secure token-based auth with configurable expiration
- **Role-Based Access Control**: Flexible permission system with user roles
- **Dynamic Model Registry**: Extensible document model system
- **Decorator API**: Complete decorator-based controllers with OpenAPI generation
- **Email Token System**: Verification, password reset, and recovery workflows
- **Multi-Language i18n**: 8+ languages with plugin architecture
- **2,541 Tests**: Comprehensive coverage

### Quick Start

```typescript
import { Application, DatabaseInitializationService } from '@digitaldefiance/node-express-suite';
import { LanguageCodes } from '@digitaldefiance/i18n-lib';

// Create application
const app = new Application({
  port: 3000,
  mongoUri: 'mongodb://localhost:27017/myapp',
  jwtSecret: process.env.JWT_SECRET,
  defaultLanguage: LanguageCodes.EN_US
});

// Initialize database with default users and roles
const result = await DatabaseInitializationService.initUserDb(app);
console.log('Admin password:', result.data.adminPassword);

// Start server
await app.start();
```

### Decorator-Based Controllers

```typescript
import {
  ApiController, Get, Post, RequireAuth, ValidateBody, Returns,
  Param, Body, CurrentUser
} from '@digitaldefiance/node-express-suite';
import { z } from 'zod';

const CreateUserSchema = z.object({
  username: z.string().min(3),
  email: z.string().email()
});

@ApiController('/users', { tags: ['Users'] })
class UserController {
  
  @Get('/:id')
  @RequireAuth()
  @Returns(200, 'User found')
  async getUser(@Param('id') id: string) {
    return { user: await this.userService.findById(id) };
  }

  @Post('/')
  @ValidateBody(CreateUserSchema)
  @Returns(201, 'User created')
  async createUser(@Body() body: z.infer<typeof CreateUserSchema>) {
    return { user: await this.userService.create(body) };
  }
}
```

### Dynamic Model Registry

```typescript
import { ModelRegistry } from '@digitaldefiance/node-express-suite';

// Register custom model
ModelRegistry.instance.register({
  modelName: 'Organization',
  schema: organizationSchema,
  model: OrganizationModel,
  collection: 'organizations',
});

// Retrieve anywhere in your app
const OrgModel = ModelRegistry.instance.get<IOrganizationDocument>('Organization').model;
const org = await OrgModel.findById(orgId);
```

### Services

```typescript
import { JwtService, UserService, RoleService, BackupCodeService } from '@digitaldefiance/node-express-suite';

// JWT authentication
const jwtService = new JwtService(app);
const { token, roles } = await jwtService.signToken(user, app.environment.jwtSecret);
const tokenUser = await jwtService.verifyToken(token);

// Role management
const roleService = new RoleService(app);
const hasPermission = await roleService.userHasRole(userId, 'admin');

// Backup codes
const backupCodeService = new BackupCodeService(app);
const codes = await backupCodeService.generateBackupCodes(userId);
```


---

## @digitaldefiance/express-suite-starter

**Automated generator for MERN stack monorepos using Nx, React 19, Express 5, and MongoDB—get a production-ready project in minutes.**

[NPM](https://www.npmjs.com/package/@digitaldefiance/express-suite-starter) · [GitHub](https://github.com/Digital-Defiance/express-suite/tree/main/packages/digitaldefiance-express-suite-starter)

### Features at a Glance

- **Nx Monorepo**: Modern build system with caching and task orchestration
- **Full Stack**: React 19 + Express 5 + MongoDB with Mongoose
- **Interactive CLI**: Chalk-powered interface with progress tracking
- **DevContainer Options**: None, simple Node.js, MongoDB, or MongoDB replica set
- **Plugin System**: Extensible with 5 lifecycle hooks
- **Rollback Support**: Checkpoint/restore for failed generations
- **Secret Generation**: Auto-generate JWT secrets and encryption keys
- **96 Tests**: Comprehensive coverage

### Quick Start

```bash
npx @digitaldefiance/express-suite-starter
```

The interactive wizard guides you through:

1. **Language Selection** - 8 supported languages
2. **Workspace Configuration** - Name, prefix, namespace, git repository
3. **Site Configuration** - Hostname, title, description
4. **Optional Projects** - E2E tests, init scripts
5. **Package Groups** - Authentication, validation, documentation
6. **DevContainer** - Development environment setup
7. **Security** - Auto-generate secrets

### What Gets Generated

```
my-app/
├── my-app-lib/              # Shared library (i18n, constants)
├── my-app-api-lib/          # API business logic
├── my-app-api/              # Express server
├── my-app-api-e2e/          # API E2E tests (Jest)
├── my-app-react/            # React frontend (Vite + MUI)
├── my-app-react-lib/        # React component library
├── my-app-react-e2e/        # React E2E tests (Playwright)
└── my-app-inituserdb/       # Database initialization
```

### Generated Scripts

```bash
yarn build:dev          # Development build
yarn serve:dev          # Start API server (dev mode)
yarn build              # Production build
yarn serve              # Start API server (production)
yarn test:all           # Run all tests
yarn inituserdb:full:drop  # Initialize database
```

### DevContainer Options

1. **None** - No devcontainer
2. **Simple** - Node.js 20 only
3. **MongoDB** - Node.js + MongoDB single instance
4. **MongoDB Replica Set** - Node.js + MongoDB with transaction support

---

## @digitaldefiance/express-suite-test-utils

**Testing utilities for Express Suite projects including custom Jest matchers, console mocks, and MongoDB memory server integration.**

[NPM](https://www.npmjs.com/package/@digitaldefiance/express-suite-test-utils) · [GitHub](https://github.com/Digital-Defiance/express-suite/tree/main/packages/digitaldefiance-express-suite-test-utils)

### Custom Jest Matchers

```typescript
import '@digitaldefiance/express-suite-test-utils';

class CustomError extends Error {
  constructor(public code: number) { super('Custom error'); }
}

// Type-safe error testing
expect(() => { throw new CustomError(404); }).toThrowType(CustomError);

// With validator
expect(() => { throw new CustomError(404); }).toThrowType(CustomError, (error) => {
  expect(error.code).toBe(404);
});
```

### Console Mocks

```typescript
import { withConsoleMocks, spyContains } from '@digitaldefiance/express-suite-test-utils';

it('should log message', async () => {
  await withConsoleMocks({ mute: true }, async (spies) => {
    console.log('test message');
    expect(spies.log).toHaveBeenCalledWith('test message');
    expect(spyContains(spies.log, 'test', 'message')).toBe(true);
  });
});
```

### MongoDB Memory Server

```typescript
import { connectMemoryDB, disconnectMemoryDB, clearMemoryDB } from '@digitaldefiance/express-suite-test-utils';

describe('User model', () => {
  beforeAll(async () => { await connectMemoryDB(); });
  afterAll(async () => { await disconnectMemoryDB(); });
  afterEach(async () => { await clearMemoryDB(); });

  it('should validate user schema', async () => {
    const user = new User({ username: 'test', email: 'test@example.com' });
    await user.validate();  // Real Mongoose validation!
  });
});
```

### i18n Test Setup

```typescript
import { setupI18nForTests } from '@digitaldefiance/express-suite-test-utils';

describe('Service Tests', () => {
  let cleanupI18n: () => void;

  beforeAll(() => {
    cleanupI18n = setupI18nForTests();  // Initializes all i18n engines
  });

  afterAll(() => { cleanupI18n(); });
});
```


---

## @digitaldefiance/express-suite-react-components

**Production-ready React MUI components for authentication, user management, and internationalization—the frontend companion to node-express-suite.**

[NPM](https://www.npmjs.com/package/@digitaldefiance/express-suite-react-components) · [GitHub](https://github.com/Digital-Defiance/express-suite/tree/main/packages/digitaldefiance-express-suite-react-components)

### Features at a Glance

- **Authentication Components**: Login, Register, Password Reset, Backup Codes, Email Verification
- **Route Guards**: PrivateRoute, UnAuthRoute for protected navigation
- **Providers**: AuthProvider, I18nProvider, AppThemeProvider, SuiteConfigProvider
- **Hooks**: useAuth, useI18n, useLocalStorage, useBackupCodes, useUserSettings
- **UI Components**: TopMenu, SideMenu, UserMenu, ConfirmationDialog, CurrencyInput
- **Extensible Forms**: Add custom fields via render props
- **227 Tests**: Comprehensive coverage

### Quick Start with Wrappers

```tsx
import { 
  SuiteConfigProvider, AuthProvider, LoginFormWrapper 
} from '@digitaldefiance/express-suite-react-components';

function App() {
  return (
    <SuiteConfigProvider
      baseUrl="https://api.example.com"
      routes={{ dashboard: '/dashboard', login: '/login' }}
      languages={[{ code: 'en-US', label: 'English (US)' }]}
    >
      <AuthProvider baseUrl="https://api.example.com" onAuthError={() => {}}>
        <LoginFormWrapper />
      </AuthProvider>
    </SuiteConfigProvider>
  );
}
```

### Authentication Components

```tsx
import { PrivateRoute, LoginForm, RegisterForm } from '@digitaldefiance/express-suite-react-components';

function App() {
  return (
    <Routes>
      <Route path="/login" element={<LoginForm onSubmit={handleLogin} />} />
      <Route path="/register" element={
        <RegisterForm 
          onSubmit={handleRegister}
          timezones={moment.tz.names()}
          getInitialTimezone={() => Intl.DateTimeFormat().resolvedOptions().timeZone}
        />
      } />
      <Route path="/dashboard" element={
        <PrivateRoute isAuthenticated={isAuth} isCheckingAuth={checking}>
          <Dashboard />
        </PrivateRoute>
      } />
    </Routes>
  );
}
```

### Extensible Forms

```tsx
import { LoginForm } from '@digitaldefiance/express-suite-react-components';
import * as Yup from 'yup';

function CustomLoginPage() {
  return (
    <LoginForm
      onSubmit={handleSubmit}
      additionalInitialValues={{ referralCode: '' }}
      additionalValidation={{ referralCode: Yup.string().optional() }}
      additionalFields={(formik) => (
        <TextField
          name="referralCode"
          label="Referral Code"
          value={formik.values.referralCode}
          onChange={formik.handleChange}
        />
      )}
    />
  );
}
```

### Providers and Hooks

```tsx
import { I18nProvider, AppThemeProvider, useAuth, useI18n } from '@digitaldefiance/express-suite-react-components';

function App() {
  return (
    <AppThemeProvider>
      <I18nProvider i18nEngine={i18nEngine}>
        <YourApp />
      </I18nProvider>
    </AppThemeProvider>
  );
}

function Dashboard() {
  const { user, logout } = useAuth();
  const { t, setLanguage } = useI18n();
  
  return (
    <div>
      <h1>{t('welcome', { name: user.username })}</h1>
      <button onClick={logout}>Logout</button>
    </div>
  );
}
```

---

## @digitaldefiance/mongoose-types

**Custom TypeScript definitions for Mongoose 8.x enabling flexible ID types beyond the default ObjectId.**

[NPM](https://www.npmjs.com/package/@digitaldefiance/mongoose-types) · [GitHub](https://github.com/Digital-Defiance/express-suite/tree/main/packages/digitaldefiance-mongoose-types)

### Why This Package?

Mongoose 8's official types enforce `_id: Types.ObjectId`, preventing custom ID types. This package provides modified definitions allowing `_id` to be any type.

### Use Cases

- String-based IDs (UUIDs, GUIDs, custom formats)
- Migrating from databases with non-ObjectId primary keys
- Cross-platform applications with custom ID providers

### Usage

```typescript
// tsconfig.json
{
  "compilerOptions": {
    "paths": {
      "mongoose": ["node_modules/@digitaldefiance/mongoose-types/src/index.d.ts"]
    }
  }
}
```

```typescript
import { Document, Schema, model } from 'mongoose';

// String-based IDs
interface IUser extends Document<string> {
  _id: string;
  username: string;
}

const userSchema = new Schema({
  _id: { type: String, required: true },
  username: String
});

const User = model<IUser>('User', userSchema);
```

---

## @digitaldefiance/express-suite-example

**Complete reference implementation demonstrating Express Suite integration in a production MERN stack.**

[GitHub](https://github.com/Digital-Defiance/express-suite-example)

A learning resource, starter template, and best practices reference for building secure, scalable, and internationalized web applications with Express Suite.


---

## Cross-Package Integration

### Binary Compatibility: ecies-lib ↔ node-ecies-lib

The browser and Node.js ECIES libraries maintain binary compatibility for seamless cross-platform encryption:

```typescript
// Browser (ecies-lib)
import { ECIESService } from '@digitaldefiance/ecies-lib';
const browserEcies = new ECIESService();
const encrypted = await browserEcies.encryptWithLength(publicKey, data);

// Node.js (node-ecies-lib) - decrypts the same data
import { ECIESService } from '@digitaldefiance/node-ecies-lib';
const nodeEcies = new ECIESService();
const decrypted = nodeEcies.decryptWithLengthAndHeader(privateKey, encrypted);
```

### Full-Stack Integration Example

```typescript
// Backend: node-express-suite with node-ecies-lib
import { Application, JwtService } from '@digitaldefiance/node-express-suite';
import { ECIESService } from '@digitaldefiance/node-ecies-lib';
import { PluginI18nEngine } from '@digitaldefiance/i18n-lib';

const app = new Application({
  mongoUri: process.env.MONGODB_URI,
  jwtSecret: process.env.JWT_SECRET
});

const ecies = new ECIESService();
const i18n = PluginI18nEngine.createInstance('app', languages);

// Frontend: express-suite-react-components with ecies-lib
import { AuthProvider, LoginForm } from '@digitaldefiance/express-suite-react-components';
import { ECIESService } from '@digitaldefiance/ecies-lib';

function App() {
  return (
    <AuthProvider apiUrl="https://api.example.com">
      <LoginForm onSuccess={(user) => console.log('Logged in:', user)} />
    </AuthProvider>
  );
}
```

### Testing Integration

```typescript
import { connectMemoryDB, withConsoleMocks } from '@digitaldefiance/express-suite-test-utils';
import { mockBackendMember } from '@digitaldefiance/node-ecies-lib/testing';
import { mockFrontendMember } from '@digitaldefiance/ecies-lib/testing';

describe('Cross-platform encryption', () => {
  beforeAll(async () => { await connectMemoryDB(); });

  it('should encrypt in browser and decrypt in Node.js', async () => {
    const browserMember = mockFrontendMember();
    const nodeMember = mockBackendMember();
    
    const encrypted = await browserMember.encryptData('secret');
    const decrypted = await nodeMember.decryptData(encrypted);
    
    expect(decrypted).toBe('secret');
  });
});
```

---

## Development

### Cloning the Repository

```bash
git clone --recursive https://github.com/Digital-Defiance/express-suite.git
cd express-suite
yarn install
```

### Working with Submodules

```bash
git submodule update --init --recursive
git submodule update --remote --merge
```

### Building and Testing

```bash
# Build all packages
yarn build

# Test all packages
yarn test

# Build specific package
yarn nx build digitaldefiance-i18n-lib

# Test specific package
yarn nx test digitaldefiance-ecies-lib

# Lint all packages
yarn nx run-many --target=lint --all
```

### Architecture

```
express-suite/
├── packages/
│   ├── digitaldefiance-i18n-lib/                 # 2,007 tests
│   ├── digitaldefiance-ecies-lib/                # 2,429 tests
│   ├── digitaldefiance-node-ecies-lib/           # 1,953 tests
│   ├── digitaldefiance-suite-core-lib/           # 512 tests
│   ├── digitaldefiance-node-express-suite/       # 2,541 tests
│   ├── digitaldefiance-express-suite-starter/    # 96 tests
│   ├── digitaldefiance-express-suite-test-utils/
│   ├── digitaldefiance-express-suite-react-components/ # 227 tests
│   ├── digitaldefiance-mongoose-types/
│   └── digitaldefiance-express-suite-example/
└── ...
```


---

## Other Packages from Digital Defiance

Beyond Express Suite, Digital Defiance maintains a collection of specialized libraries for cryptography, hardware acceleration, and distributed systems.

### Ephemeral Encrypted Collaboration Protocol (EECP)

A zero-knowledge, self-destructing collaborative workspace system enabling real-time document collaboration with cryptographic guarantees of content unreadability after expiration.

| Package | Description |
|---------|-------------|
| [@digitaldefiance/eecp-protocol](https://www.npmjs.com/package/@digitaldefiance/eecp-protocol) | Core types and protocol definitions including workspace configuration, encrypted operations, WebSocket message envelopes, and temporal scheduling interfaces. |
| [@digitaldefiance/eecp-crypto](https://www.npmjs.com/package/@digitaldefiance/eecp-crypto) | Temporal key management with HKDF-SHA256 derivation, AES-256-GCM time-locked encryption, ECIES multi-recipient encryption, zero-knowledge authentication, and cryptographic commitments for provable key deletion. 100+ property-based tests. |
| [@digitaldefiance/eecp-crdt](https://www.npmjs.com/package/@digitaldefiance/eecp-crdt) | Encrypted conflict-free replicated data types built on Yjs for deterministic conflict resolution with encrypted content payloads and temporal garbage collection. |
| [@digitaldefiance/eecp-client](https://www.npmjs.com/package/@digitaldefiance/eecp-client) | Browser client library with React hooks for collaborative editing. Provides WebSocket connection management, IndexedDB key storage, and automatic reconnection with exponential backoff. |
| [@digitaldefiance/eecp-server](https://www.npmjs.com/package/@digitaldefiance/eecp-server) | Express + WebSocket server for zero-knowledge operation routing. Manages workspace lifecycle, participant authentication, encrypted operation broadcasting, rate limiting, and temporal cleanup with Prometheus metrics. |
| [@digitaldefiance/eecp-cli](https://www.npmjs.com/package/@digitaldefiance/eecp-cli) | Command-line interface for EECP testing and automation. Create workspaces, join sessions, export documents, and interact with a full-featured interactive editor. |
| [@digitaldefiance/eecp-browser](https://www.npmjs.com/package/@digitaldefiance/eecp-browser) | Browser-compatible server and client components for EECP integration in web applications. |

### Apple Silicon Hardware Acceleration

High-performance native libraries optimized for Apple M1/M2/M3/M4 processors.

| Package | Description |
|---------|-------------|
| [@digitaldefiance/node-accelerate](https://www.npmjs.com/package/@digitaldefiance/node-accelerate) | Apple Accelerate framework bindings for Node.js. Up to 305x faster matrix operations and 5-10x faster vector operations via AMX, NEON SIMD, and optimized FFT. 80+ hardware-accelerated functions including BLAS, vDSP, and vForce operations. |
| [@digitaldefiance/node-rs-accelerate](https://www.npmjs.com/package/@digitaldefiance/node-rs-accelerate) | High-performance Reed-Solomon error correction with up to 30 GB/s encoding throughput. Features Metal GPU acceleration, systematic encoding, GF(2^8) and GF(2^16) field sizes, streaming API, optional compression, and SHA-256 hash validation. |
| [@digitaldefiance/node-zk-accelerate](https://www.npmjs.com/package/@digitaldefiance/node-zk-accelerate) | Zero-Knowledge Proof acceleration with 10x+ MSM speedup and 5x+ NTT speedup over WASM. Supports BN254 and BLS12-381 curves with automatic hardware detection for NEON, AMX, SME, Metal GPU, and unified memory. |
| [@digitaldefiance/node-fhe-accelerate](https://www.npmjs.com/package/@digitaldefiance/node-fhe-accelerate) | Fully Homomorphic Encryption acceleration using TFHE scheme. Enables privacy-preserving computation on encrypted data with <1ms homomorphic addition, <50ms multiplication, and <20ms bootstrapping. Includes ZK proofs (Bulletproofs, Groth16, PLONK) for secure voting applications processing 10,000+ encrypted ballots per second. |

### Cryptography & Security

| Package | Description |
|---------|-------------|
| [@digitaldefiance/secrets](https://www.npmjs.com/package/@digitaldefiance/secrets) | Shamir's Secret Sharing implementation for splitting secrets into N shares with configurable threshold reconstruction. Ideal for distributed key management and secure backup systems. |
| [@digitaldefiance/enclave-bridge-client](https://www.npmjs.com/package/@digitaldefiance/enclave-bridge-client) | TypeScript client for Enclave Bridge, a macOS app bridging Node.js to Apple's Secure Enclave via Unix domain socket. Features P-256 signing with hardware-protected keys, ECIES encryption compatible with node-ecies-lib, auto-reconnection, request queuing, and streaming support for large files. |

### Utilities

| Package | Description |
|---------|-------------|
| [@digitaldefiance/branded-enum](https://www.npmjs.com/package/@digitaldefiance/branded-enum) | Runtime-identifiable enum-like types for TypeScript with zero runtime overhead. Solves the problem of overlapping string values across libraries by embedding metadata for runtime identification, type guards with automatic narrowing, and a global registry across bundles. |
| [@digitaldefiance/luhn-mod-n](https://www.npmjs.com/package/@digitaldefiance/luhn-mod-n) | Enterprise-grade Luhn Mod N algorithm implementation for TypeScript. Generates and validates checksums for alphanumeric strings with support for bases 2-16, useful for custom identifiers, codes, and validation systems. |
| [@digitaldefiance/reed-solomon-erasure.wasm](https://www.npmjs.com/package/@digitaldefiance/reed-solomon-erasure.wasm) | Reed-Solomon erasure coding compiled to WebAssembly. Works in both browser and Node.js with async/sync instantiation, TypeScript support, and ESM/CommonJS builds. Fork of @subspace/reed-solomon-erasure.wasm with browser compatibility fixes. |

---

## License

MIT © Digital Defiance, Jessica Mulein
