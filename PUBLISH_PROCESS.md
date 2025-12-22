# Express Suite Build & Publish Process

## Overview

The express-suite packages are published to npm and consumed by DigitalBurnbag. This document describes the reliable build and publish workflow.

## Package Dependency Order

Packages must be built and published in this order:

0. **Foundation packages** (no dependencies between each other, can be published in parallel):
   - `@digitaldefiance/express-suite-test-utils` - Test utilities (no dependencies)
   - `@digitaldefiance/mongoose-types` - MongoDB type definitions (no dependencies)

1. `@digitaldefiance/i18n-lib` - Depends on test-utils (devDependency only)
2. `@digitaldefiance/ecies-lib` - Depends on i18n-lib, test-utils (devDependency only)
3. `@digitaldefiance/node-ecies-lib` - Depends on i18n-lib, ecies-lib, test-utils
4. `@digitaldefiance/suite-core-lib` - Depends on node-ecies-lib
5. `@digitaldefiance/node-express-suite` - Depends on suite-core-lib
6. `@digitaldefiance/express-suite-react-components` - Depends on suite-core-lib

## Development Workflow

### Local Development with DigitalBurnbag

When making changes to express-suite packages and testing them in DigitalBurnbag:

```bash
# From DigitalBurnbag root
./sync-express-suite.sh
```

This script will:

- Build all express-suite packages
- Copy built packages to DigitalBurnbag's node_modules
- Allow you to test changes immediately

**Note:** Running `yarn` in DigitalBurnbag will overwrite these with npm versions.

### Building Individual Packages

```bash
cd express-suite

# Build single package
yarn workspace @digitaldefiance/node-express-suite build

# Or using nx
npx nx build digitaldefiance-node-express-suite
```

### Building All Packages

```bash
cd express-suite
yarn build:stream
```

## Publishing to npm

### Prerequisites

1. Ensure you're logged into npm:

   ```bash
   npm login
   ```

2. Verify you have publish access to @digitaldefiance org

3. Ensure all tests pass:

   ```bash
   cd express-suite
   yarn test
   ```

### Publishing Process

Use the automated cascading publish script:

```bash
cd express-suite
./cascading-publish.sh
```

This script will:

1. Prompt for version bumps (patch/minor/major) for each package you choose to publish
2. Automatically update dependency versions in dependent packages
3. Update lockfiles after dependency changes
4. Build packages from dist/packages/ (not source)
5. Publish to npm with proper versioning cascade

**Important Notes:**
- Version prompts happen BEFORE slow yarn install operations
- Dependencies are automatically updated when publishing dependent packages
- test-utils is a devDependency for i18n-lib and ecies-lib (not a runtime dependency)
- Publishing happens in correct dependency order
- You can skip packages you don't want to publish by answering 'N'

### Manual Publishing (if needed)

If you need to publish individual packages manually:

```bash
cd express-suite

# Build the package first
npx nx build <package-name>

# Publish from dist directory
cd dist/packages/<package-name>
npm publish --access public
```

**Critical:** Always publish from `dist/packages/<package-name>`, never from the source directory. The source directories don't have compiled JS files.

## Troubleshooting

### Problem: Published package missing compiled JS files

**Symptoms:**

```
Error: Cannot find module '.../node_modules/@digitaldefiance/package-name/src/index.js'
```

**Solution:**

1. Check that `dist/packages/package-name/src/` contains `.js` files (not just `.ts`)
2. Verify package.json `main` field points to `src/index.js`
3. Re-run build and verify: `./publish-all.sh`

### Problem: Type mismatches between packages

**Symptoms:**

```
Type 'SecureBuffer' is not assignable to type 'SecureBuffer'
```

**Cause:** Multiple versions of a package installed

**Solution:**

1. Check DigitalBurnbag's `resolutions` in package.json
2. Ensure all packages use the same version
3. Run `yarn` to apply resolutions

### Problem: Local changes not reflected in DigitalBurnbag

**Solution:**

```bash
# From DigitalBurnbag root
./sync-express-suite.sh
```

## Version Management

### Automated Version Bumping

The `cascading-publish.sh` script handles version bumping automatically. For each package you choose to publish, it will:

1. Prompt you to select patch/minor/major version bump
2. Update the package.json version
3. Automatically update that version in all dependent packages

You don't need to manually bump versions or update dependencies - the script cascades changes automatically.

### Manual Version Management (if needed)

If you need to manually update versions without publishing:

```bash
cd express-suite/packages/digitaldefiance-<package-name>
npm version patch  # or minor, major
```

Then update dependent packages using:
```bash
npm pkg set dependencies.@digitaldefiance/<package-name>=<new-version>
```

### Updating DigitalBurnbag After Publishing

After publishing new versions, update DigitalBurnbag's package.json resolutions:

```json
"resolutions": {
  "@digitaldefiance/i18n-lib": "3.8.11",
  "@digitaldefiance/ecies-lib": "^4.4.19",
  "@digitaldefiance/node-ecies-lib": "^4.4.18",
  // ... other packages
}
```

Then run `yarn` to apply the new versions.

## CI/CD (Future)

TODO: Automate this process with:

- GitHub Actions workflow
- Automatic version bumping
- Changelog generation
- Automated testing before publish
- npm publish with --provenance flag
