#!/usr/bin/env python3
"""Discover packages and flake inputs for update checking.

This script discovers all flake inputs, outputting a matrix JSON suitable
for GitHub Actions. Since avim.nix has no versioned packages (only a single
Neovim configuration), we only discover flake inputs.
"""

import json
import os
from dataclasses import dataclass
from pathlib import Path

try:
    import yaml

    HAS_YAML = True
except ImportError:
    HAS_YAML = False


@dataclass
class MatrixItem:
    """Represents an item in the update matrix."""

    type: str
    name: str
    current_version: str

    def to_dict(self) -> dict[str, str]:
        """Convert to dictionary for JSON serialization."""
        return {
            "type": self.type,
            "name": self.name,
            "current_version": self.current_version,
        }


def load_update_config() -> dict:
    """Load update configuration from .github/config/update-config.yml."""
    config_path = Path(".github/config/update-config.yml")
    if not config_path.exists():
        return {}
    if not HAS_YAML:
        print("Warning: pyyaml not installed, skipping update config")
        return {}
    try:
        return yaml.safe_load(config_path.read_text()) or {}
    except yaml.YAMLError as e:
        print(f"Warning: Failed to parse update config: {e}")
        return {}


def discover_flake_inputs(
    inputs_filter: str | None, skip_inputs: list[str]
) -> list[MatrixItem]:
    """Discover flake inputs from flake.lock."""
    items: list[MatrixItem] = []

    print("Discovering flake inputs...")

    lock_path = Path("flake.lock")
    if not lock_path.exists():
        print("No flake.lock found, skipping input updates")
        return items

    lock_data = json.loads(lock_path.read_text())
    nodes = lock_data.get("nodes", {})

    # Get only direct inputs from root
    root_inputs = nodes.get("root", {}).get("inputs", {})

    if inputs_filter:
        input_names = inputs_filter.split()
    else:
        input_names = sorted(root_inputs.keys())

    for input_name in input_names:
        if input_name not in nodes:
            continue

        if input_name in skip_inputs:
            print(f"Skipping {input_name} (in skip list)")
            continue

        locked = nodes[input_name].get("locked", {})
        rev = locked.get("rev", "unknown")[:8]
        items.append(
            MatrixItem(
                type="flake-input",
                name=input_name,
                current_version=rev,
            )
        )

    return items


def main() -> None:
    """Discover flake inputs, output matrix for GitHub Actions."""
    update_type = os.environ.get("UPDATE_TYPE", "").strip().lower()
    inputs_env = os.environ.get("INPUTS", "")
    github_output = os.environ.get("GITHUB_OUTPUT")

    # Load update config for skip lists
    update_config = load_update_config()
    skip_inputs = update_config.get("skip", {}).get("inputs", [])

    # Determine what to update
    update_inputs = update_type in ("", "inputs")

    print("=== Discovery Configuration ===")
    print(f"UPDATE_TYPE: {update_type or '<all>'}")
    print(f"INPUTS: {inputs_env or '<all>'}")
    if skip_inputs:
        print(f"Skip inputs: {', '.join(skip_inputs)}")
    print()

    # Discover items
    matrix_items: list[MatrixItem] = []
    if update_inputs:
        matrix_items.extend(discover_flake_inputs(inputs_env or None, skip_inputs))

    print()
    print("=== Discovery Results ===")

    # Create matrix JSON
    matrix: dict[str, list[dict[str, str]]]
    if not matrix_items:
        matrix = {"include": []}
        has_updates = False
        print("No items to update")
    else:
        matrix = {"include": [item.to_dict() for item in matrix_items]}
        has_updates = True
        print(f"Found {len(matrix_items)} item(s) to update")

    matrix_json = json.dumps(matrix, separators=(",", ":"))

    # Output for GitHub Actions
    if github_output:
        with Path(github_output).open("a") as f:
            f.write(f"matrix={matrix_json}\n")
            f.write(f"has-updates={str(has_updates).lower()}\n")
    else:
        # Local testing output
        print()
        print("=== GitHub Actions Output Format ===")
        print(f"matrix={matrix_json}")
        print(f"has-updates={str(has_updates).lower()}")

        print()
        print("=== Pretty-printed Matrix ===")
        print(json.dumps(matrix, indent=2))

        print()
        print("=== Summary ===")
        if has_updates:
            print("Items by type:")
            type_counts: dict[str, int] = {}
            for item in matrix_items:
                type_counts[item.type] = type_counts.get(item.type, 0) + 1
            for item_type, count in sorted(type_counts.items()):
                print(f"  {count} {item_type}")


if __name__ == "__main__":
    main()
