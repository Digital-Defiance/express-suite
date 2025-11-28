#!/bin/bash

# Script to run audit on all Express Suite packages
# Saves results to individual files

AUDIT_DIR="audit-results"
mkdir -p "$AUDIT_DIR"

echo "Starting Express Suite Documentation Audit"
echo "=========================================="
echo ""

# Array of packages to audit
packages=(
  "digitaldefiance-i18n-lib"
  "digitaldefiance-ecies-lib"
  "digitaldefiance-node-ecies-lib"
  "digitaldefiance-suite-core-lib"
  "digitaldefiance-node-express-suite"
  "digitaldefiance-express-suite-react-components"
  "digitaldefiance-express-suite-test-utils"
  "digitaldefiance-express-suite-starter"
)

# Run audit on each package
for pkg in "${packages[@]}"; do
  echo "Auditing $pkg..."
  output_file="$AUDIT_DIR/${pkg}.txt"
  
  # Run audit with timeout, save output
  timeout 30 node tools/audit/dist/cli.js audit:package "$pkg" \
    --no-coverage \
    --no-cross-package \
    --no-examples \
    --no-references \
    -v > "$output_file" 2>&1
  
  exit_code=$?
  
  if [ $exit_code -eq 0 ]; then
    echo "  ✓ Completed successfully"
  elif [ $exit_code -eq 124 ]; then
    echo "  ⚠ Timed out (results may be incomplete)"
  else
    echo "  ✗ Failed with exit code $exit_code"
  fi
  
  echo ""
done

echo "=========================================="
echo "Audit complete. Results saved to $AUDIT_DIR/"
echo ""
echo "Summary:"
for pkg in "${packages[@]}"; do
  output_file="$AUDIT_DIR/${pkg}.txt"
  if [ -f "$output_file" ]; then
    # Extract key metrics from output
    completeness=$(grep "Completeness:" "$output_file" | head -1 | awk '{print $2}')
    undocumented=$(grep "Undocumented Exports:" "$output_file" | head -1 | awk '{print $3}')
    echo "  $pkg: $completeness completeness, $undocumented undocumented exports"
  fi
done
