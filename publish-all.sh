#!/bin/bash

# Comprehensive build and publish script for express-suite packages
# This ensures all packages are built and published in the correct order

set -e  # Exit on error

echo "==========================================="
echo "Express Suite - Build & Publish Pipeline"
echo "==========================================="
echo ""

# Colors for output
GREEN='\033[0;32m'
RED='\033[0;31m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Function to check if a package has changes
check_if_published() {
    local package_name=$1
    local package_version=$2
    
    echo -e "${YELLOW}Checking if $package_name@$package_version is already published...${NC}"
    
    if npm view "$package_name@$package_version" version &>/dev/null; then
        echo -e "${YELLOW}Warning: $package_name@$package_version already exists on npm${NC}"
        read -p "Do you want to continue and publish anyway? (y/N) " -n 1 -r
        echo
        if [[ ! $REPLY =~ ^[Yy]$ ]]; then
            return 1
        fi
    fi
    return 0
}

# Function to verify build output
verify_build() {
    local package_name=$1
    local dist_path="dist/packages/$package_name"
    
    echo -e "${YELLOW}Verifying build output for $package_name...${NC}"
    
    if [ ! -d "$dist_path" ]; then
        echo -e "${RED}✗ Build output directory not found: $dist_path${NC}"
        return 1
    fi
    
    if [ ! -f "$dist_path/src/index.js" ]; then
        echo -e "${RED}✗ Compiled index.js not found: $dist_path/src/index.js${NC}"
        return 1
    fi
    
    if [ ! -f "$dist_path/package.json" ]; then
        echo -e "${RED}✗ package.json not found: $dist_path/package.json${NC}"
        return 1
    fi
    
    echo -e "${GREEN}✓ Build output verified${NC}"
    return 0
}

# Function to build a package
build_package() {
    local package_name=$1
    echo ""
    echo -e "${YELLOW}=========================================${NC}"
    echo -e "${YELLOW}Building $package_name...${NC}"
    echo -e "${YELLOW}=========================================${NC}"
    
    NODE_OPTIONS='--max-old-space-size=16384' npx nx build "$package_name" --skip-nx-cache
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ Build successful${NC}"
        verify_build "$package_name"
        return $?
    else
        echo -e "${RED}✗ Build failed${NC}"
        return 1
    fi
}

# Function to publish a package
publish_package() {
    local package_name=$1
    local dist_path="dist/packages/$package_name"
    
    echo ""
    echo -e "${YELLOW}=========================================${NC}"
    echo -e "${YELLOW}Publishing $package_name...${NC}"
    echo -e "${YELLOW}=========================================${NC}"
    
    # Get version from package.json
    local version=$(node -p "require('./$dist_path/package.json').version")
    
    # Check if already published
    if ! check_if_published "@digitaldefiance/$package_name" "$version"; then
        echo -e "${YELLOW}Skipping $package_name${NC}"
        return 0
    fi
    
    # Show what will be published
    echo -e "${YELLOW}Package contents:${NC}"
    ls -la "$dist_path" | head -15
    
    # Confirm before publishing
    echo ""
    read -p "Publish @digitaldefiance/$package_name@$version to npm? (y/N) " -n 1 -r
    echo
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        echo -e "${YELLOW}Skipping $package_name${NC}"
        return 0
    fi
    
    # Publish
    npm publish --registry https://registry.npmjs.org/ "$dist_path" --access public
    
    if [ $? -eq 0 ]; then
        echo -e "${GREEN}✓ Published successfully${NC}"
        return 0
    else
        echo -e "${RED}✗ Publish failed${NC}"
        return 1
    fi
}

# Build and publish in dependency order
PACKAGES=(
    "digitaldefiance-i18n-lib"
    "digitaldefiance-ecies-lib"
    "digitaldefiance-node-ecies-lib"
    "digitaldefiance-suite-core-lib"
    "digitaldefiance-express-suite-test-utils"
    "digitaldefiance-node-express-suite"
    "digitaldefiance-express-suite-react-components"
)

echo -e "${YELLOW}Packages to build and publish:${NC}"
for pkg in "${PACKAGES[@]}"; do
    echo "  - $pkg"
done
echo ""

read -p "Continue with build and publish process? (y/N) " -n 1 -r
echo
if [[ ! $REPLY =~ ^[Yy]$ ]]; then
    echo "Aborted."
    exit 0
fi

# Build all packages first
echo ""
echo "==========================================="
echo "PHASE 1: Building all packages"
echo "==========================================="

for package in "${PACKAGES[@]}"; do
    if ! build_package "$package"; then
        echo -e "${RED}Build failed for $package. Stopping.${NC}"
        exit 1
    fi
done

echo ""
echo -e "${GREEN}==========================================="
echo "All packages built successfully!"
echo "==========================================${NC}"

# Publish all packages
echo ""
echo "==========================================="
echo "PHASE 2: Publishing packages"
echo "==========================================="

for package in "${PACKAGES[@]}"; do
    publish_package "$package"
done

echo ""
echo -e "${GREEN}==========================================="
echo "Publish process complete!"
echo "==========================================${NC}"
