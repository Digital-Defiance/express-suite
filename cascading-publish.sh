#!/bin/bash

# Cascading publish script for Digital Defiance packages
# Handles dependency chain: i18n -> ecies -> node-ecies -> suite-core -> node-express-suite

set -e

cd "$(dirname "$0")"

echo "==========================================="
echo "Cascading Publish Process"
echo "==========================================="
echo ""
echo "Dependency Graph:"
echo "  Independent packages (no DD deps):"
echo "    - express-suite-test-utils"
echo "    - mongoose-types"
echo "  Dependency chain:"
echo "    i18n-lib (root)"
echo "      ├─> ecies-lib (also uses test-utils)"
echo "      │   └─> node-ecies-lib (also uses test-utils)"
echo "      └─> suite-core-lib"
echo "  All converge to node-express-suite"
echo "  express-suite-react-components (uses suite-core)"
echo ""
echo "This will publish packages in dependency order,"
echo "updating versions and dependencies as it goes."
echo ""
read -p "Continue? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 1
fi

# Function to get current version from package.json
get_version() {
    local package_dir=$1
    node -p "require('./packages/$package_dir/package.json').version"
}

# Function to bump version
bump_version() {
    local package_dir=$1
    local bump_type=${2:-patch}  # patch, minor, or major
    
    echo "Current version: $(get_version $package_dir)" >&2
    read -p "Bump type (patch/minor/major) [$bump_type]: " input_bump >&2
    bump_type=${input_bump:-$bump_type}
    
    cd "packages/$package_dir"
    # Use node to bump version instead of npm to avoid workspace resolution issues
    local new_version=$(node -e "
        const fs = require('fs');
        const pkg = JSON.parse(fs.readFileSync('./package.json', 'utf8'));
        const [major, minor, patch] = pkg.version.split('.').map(Number);
        let newVersion;
        switch ('$bump_type') {
            case 'major': newVersion = \`\${major + 1}.0.0\`; break;
            case 'minor': newVersion = \`\${major}.\${minor + 1}.0\`; break;
            default: newVersion = \`\${major}.\${minor}.\${patch + 1}\`; break;
        }
        pkg.version = newVersion;
        fs.writeFileSync('./package.json', JSON.stringify(pkg, null, 2) + '\n');
        console.log(newVersion);
    ")
    cd ../..
    
    echo "New version: $new_version" >&2
    echo $new_version
}

# Function to update dependency version in package.json
update_dependency() {
    local package_dir=$1
    local dep_name=$2
    local dep_version=$3
    
    echo "Updating $dep_name to $dep_version in $package_dir" >&2
    cd "packages/$package_dir"
    npm pkg set "dependencies.$dep_name=$dep_version"
    cd ../..
}

# Function to run yarn install at workspace root
update_lockfile() {
    echo "Updating yarn lockfile..." >&2
    yarn install
}

# Function to build and publish
build_and_publish() {
    local package_name=$1
    local dist_dir=$2
    
    echo ""
    echo "Building $package_name..."
    NODE_OPTIONS='--max-old-space-size=16384' npx nx build $package_name --skip-nx-cache
    
    echo "Publishing $package_name from dist/packages/$dist_dir..."
    npm publish --registry https://registry.npmjs.org/ "dist/packages/$dist_dir" --access public
    
    echo "✓ Published $package_name"
}

# Track versions for cascading updates
declare -A VERSIONS

# 0a. express-suite-test-utils (no DD dependencies - must be first!)
echo ""
echo "========== 0a. express-suite-test-utils =========="
read -p "Publish express-suite-test-utils? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    VERSIONS[test_utils]=$(bump_version "digitaldefiance-express-suite-test-utils")
    build_and_publish "digitaldefiance-express-suite-test-utils" "digitaldefiance-express-suite-test-utils"
else
    VERSIONS[test_utils]=$(get_version "digitaldefiance-express-suite-test-utils")
    echo "Using existing express-suite-test-utils version: ${VERSIONS[test_utils]}"
fi

# 0b. mongoose-types (no DD dependencies - independent)
echo ""
echo "========== 0b. mongoose-types =========="
read -p "Publish mongoose-types? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    VERSIONS[mongoose_types]=$(bump_version "digitaldefiance-mongoose-types")
    build_and_publish "digitaldefiance-mongoose-types" "digitaldefiance-mongoose-types"
else
    VERSIONS[mongoose_types]=$(get_version "digitaldefiance-mongoose-types")
    echo "Using existing mongoose-types version: ${VERSIONS[mongoose_types]}"
fi

# 1. i18n-lib (no DD dependencies)
echo ""
echo "========== 1. i18n-lib =========="
read -p "Publish i18n-lib? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    VERSIONS[i18n]=$(bump_version "digitaldefiance-i18n-lib")
    build_and_publish "digitaldefiance-i18n-lib" "digitaldefiance-i18n-lib"
else
    VERSIONS[i18n]=$(get_version "digitaldefiance-i18n-lib")
    echo "Using existing i18n-lib version: ${VERSIONS[i18n]}"
fi

# 2. ecies-lib (depends on i18n-lib, test-utils)
echo ""
echo "========== 2. ecies-lib =========="
read -p "Publish ecies-lib? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    VERSIONS[ecies]=$(bump_version "digitaldefiance-ecies-lib")
    update_dependency "digitaldefiance-ecies-lib" "@digitaldefiance/i18n-lib" "${VERSIONS[i18n]}"
    update_lockfile
    build_and_publish "digitaldefiance-ecies-lib" "digitaldefiance-ecies-lib"
else
    VERSIONS[ecies]=$(get_version "digitaldefiance-ecies-lib")
    echo "Using existing ecies-lib version: ${VERSIONS[ecies]}"
fi

# 3. node-ecies-lib (depends on i18n-lib, ecies-lib, test-utils)
echo ""
echo "========== 3. node-ecies-lib =========="
read -p "Publish node-ecies-lib? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    VERSIONS[node_ecies]=$(bump_version "digitaldefiance-node-ecies-lib")
    update_dependency "digitaldefiance-node-ecies-lib" "@digitaldefiance/i18n-lib" "${VERSIONS[i18n]}"
    update_dependency "digitaldefiance-node-ecies-lib" "@digitaldefiance/ecies-lib" "${VERSIONS[ecies]}"
    update_dependency "digitaldefiance-node-ecies-lib" "@digitaldefiance/express-suite-test-utils" "${VERSIONS[test_utils]}"
    update_lockfile
    build_and_publish "digitaldefiance-node-ecies-lib" "digitaldefiance-node-ecies-lib"
else
    VERSIONS[node_ecies]=$(get_version "digitaldefiance-node-ecies-lib")
    echo "Using existing node-ecies-lib version: ${VERSIONS[node_ecies]}"
fi

# 4. suite-core-lib (depends on i18n-lib, ecies-lib)
echo ""
echo "========== 4. suite-core-lib =========="
read -p "Publish suite-core-lib? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    VERSIONS[suite_core]=$(bump_version "digitaldefiance-suite-core-lib")
    update_dependency "digitaldefiance-suite-core-lib" "@digitaldefiance/i18n-lib" "${VERSIONS[i18n]}"
    update_dependency "digitaldefiance-suite-core-lib" "@digitaldefiance/ecies-lib" "${VERSIONS[ecies]}"
    update_lockfile
    build_and_publish "digitaldefiance-suite-core-lib" "digitaldefiance-suite-core-lib"
else
    VERSIONS[suite_core]=$(get_version "digitaldefiance-suite-core-lib")
    echo "Using existing suite-core-lib version: ${VERSIONS[suite_core]}"
fi

# 5. node-express-suite (depends on: i18n, ecies, node-ecies, suite-core, mongoose-types)
echo ""
echo "========== 5. node-express-suite =========="
read -p "Publish node-express-suite? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    VERSIONS[node_express]=$(bump_version "digitaldefiance-node-express-suite")
    update_dependency "digitaldefiance-node-express-suite" "@digitaldefiance/i18n-lib" "${VERSIONS[i18n]}"
    update_dependency "digitaldefiance-node-express-suite" "@digitaldefiance/ecies-lib" "${VERSIONS[ecies]}"
    update_dependency "digitaldefiance-node-express-suite" "@digitaldefiance/node-ecies-lib" "${VERSIONS[node_ecies]}"
    update_dependency "digitaldefiance-node-express-suite" "@digitaldefiance/suite-core-lib" "${VERSIONS[suite_core]}"
    update_dependency "digitaldefiance-node-express-suite" "@digitaldefiance/mongoose-types" "${VERSIONS[mongoose_types]}"
    update_lockfile
    build_and_publish "digitaldefiance-node-express-suite" "digitaldefiance-node-express-suite"
else
    VERSIONS[node_express]=$(get_version "digitaldefiance-node-express-suite")
    echo "Using existing node-express-suite version: ${VERSIONS[node_express]}"
fi

# 6. express-suite-react-components (depends on suite-core, i18n)
echo ""
echo "========== 6. express-suite-react-components =========="
read -p "Publish express-suite-react-components? (y/N) " -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    VERSIONS[react_components]=$(bump_version "digitaldefiance-express-suite-react-components")
    update_dependency "digitaldefiance-express-suite-react-components" "@digitaldefiance/i18n-lib" "${VERSIONS[i18n]}"
    update_dependency "digitaldefiance-express-suite-react-components" "@digitaldefiance/suite-core-lib" "${VERSIONS[suite_core]}"
    update_lockfile
    build_and_publish "digitaldefiance-express-suite-react-components" "digitaldefiance-express-suite-react-components"
else
    VERSIONS[react_components]=$(get_version "digitaldefiance-express-suite-react-components")
    echo "Using existing express-suite-react-components version: ${VERSIONS[react_components]}"
fi

echo ""
echo "==========================================="
echo "✓ Cascading publish complete!"
echo "==========================================="
echo ""
echo "Published versions:"
echo "  i18n-lib: ${VERSIONS[i18n]}"
echo "  ecies-lib: ${VERSIONS[ecies]}"
echo "  node-ecies-lib: ${VERSIONS[node_ecies]}"
echo "  suite-core-lib: ${VERSIONS[suite_core]}"
echo "  express-suite-test-utils: ${VERSIONS[test_utils]}"
echo "  mongoose-types: ${VERSIONS[mongoose_types]}"
echo "  node-express-suite: ${VERSIONS[node_express]}"
echo "  express-suite-react-components: ${VERSIONS[react_components]}"
echo ""
echo "Next steps for DigitalBurnbag:"
echo "1. Update resolutions in package.json to:"
echo "   \"@digitaldefiance/i18n-lib\": \"${VERSIONS[i18n]}\""
echo "   \"@digitaldefiance/ecies-lib\": \"^${VERSIONS[ecies]}\""
echo "   \"@digitaldefiance/node-ecies-lib\": \"^${VERSIONS[node_ecies]}\""
echo "2. Run 'yarn' to update lockfiles"
echo "3. Run './sync-express-suite.sh' or 'yarn' to get latest packages"
