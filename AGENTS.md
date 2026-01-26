# Development Commands

## Build/Test/Lint
- **Build package**: `nix build .#avim`
- **Run checks**: `nix flake check`
- **Format code**: `nix fmt` (uses treefmt-nix: deadnix, nixfmt, statix, shfmt, stylua, yamlfmt)
- **Clean build artifacts**: `rm -rf result* *.qcow2 *.fd`

## Code Style Guidelines

### Nix Files
- **Indentation**: 2 spaces
- **Naming**: camelCase for variables, kebab-case for attributes
- **Structure**: Use `with pkgs;` for package imports, organize logically
- **Comments**: Minimal, only when necessary for clarity

### Shell Scripts
- **Shebang**: `#!/usr/bin/env bash`
- **Options**: `set -euo pipefail` for strict error handling
- **Variables**: Descriptive names in UPPER_SNAKE_CASE for globals
- **Error handling**: Use `||` for fallbacks, check exit codes

### Lua/Neovim Config
- **Indentation**: 2 spaces
- **Keymaps**: Descriptive with `options.desc` for discoverability
- **Organization**: Group related functionality, use logical plugin ordering
- **Functions**: Use `__raw` for complex Lua functions in Nix expressions

### General
- **Formatting**: Automated via treefmt-nix - run `nix fmt` before committing
- **Testing**: Verify builds with `nix flake check` and manual testing
- **Documentation**: Update README.md when changing user-facing features