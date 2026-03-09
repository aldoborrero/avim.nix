#!/usr/bin/env bash
set -euo pipefail

# Script to perform updates for flake inputs
# Usage: update.sh <type> <name>
#   type: "flake-input"
#   name: input name

type="$1"
name="$2"

# Outputs are written to GITHUB_OUTPUT if available
output_var="${GITHUB_OUTPUT:-/dev/stdout}"

if [ "$type" = "flake-input" ]; then
  echo "Updating input $name..."

  if nix flake update "$name"; then
    # Check if there were actual changes
    if git diff --quiet; then
      echo "No changes detected"
      echo "updated=false" >>"$output_var"
      exit 0
    fi

    # Get new revision from flake.lock directly
    new_rev=$(jq -r ".nodes.\"$name\".locked.rev // \"unknown\"" flake.lock | head -c 8)
    echo "New revision: $new_rev"

    echo "updated=true" >>"$output_var"
    echo "new_version=$new_rev" >>"$output_var"
  else
    echo "::error::Failed to update $name"
    exit 1
  fi
else
  echo "Error: Unknown type '$type'. Must be 'flake-input'."
  exit 1
fi
