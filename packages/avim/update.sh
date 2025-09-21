#!/usr/bin/env bash
set -euo pipefail

# Update script for avim package using date-based versioning (YYYY.MM.DD.REV)

SCRIPT_DIR=$(dirname "$(readlink -f "$0")")
cd "$SCRIPT_DIR/../.." # Navigate to repository root

# Check if relevant inputs were updated (nixpkgs or nixvim)
if git diff --name-only flake.lock | grep -q -E "nixpkgs|nixvim"; then
  echo "Detected nixpkgs or nixvim update in flake.lock"

  # Generate new date-based version
  today=$(date +"%Y.%m.%d")

  # Extract current version to check if we need to increment revision
  current_version=$(grep -oP 'version = "\K[^"]+' packages/avim/default.nix || echo "0.0.0.0")
  current_date=$(echo "$current_version" | cut -d. -f1-3)

  if [ "$today" = "$current_date" ]; then
    # Same day, increment revision
    current_rev=$(echo "$current_version" | cut -d. -f4)
    new_rev=$((current_rev + 1))
    new_version="${today}.${new_rev}"
  else
    # New day, reset revision to 0
    new_version="${today}.0"
  fi

  # Update version in default.nix
  sed -i "s/version = \"$current_version\"/version = \"$new_version\"/" packages/avim/default.nix

  echo "Updated avim to version $new_version to reflect dependency changes"
  exit 0
fi

echo "No relevant input updates for avim at this time"
exit 0
