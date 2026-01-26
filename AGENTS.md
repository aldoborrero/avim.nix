# AGENTS.md - LLM Development Guide

## Project Overview

avim.nix is a reproducible Neovim configuration built with Nixvim. All configuration is declarative Nix - no imperative Lua files. The entire editor setup is defined in Nix expressions that compile to a working Neovim installation.

## Architecture

```
avim.nix/
├── flake.nix                 # Flake inputs and Blueprint configuration
├── formatter.nix             # treefmt-nix setup
├── devshell.nix              # Development environment
└── packages/avim/
    ├── default.nix           # Package wrapper script (rarely modified)
    └── config.nix            # Main config: options, plugins, keymaps
```

## Key Files

| File | Purpose | When to Modify |
|------|---------|----------------|
| `packages/avim/config.nix` | All Neovim configuration | Adding plugins, keymaps, LSP servers, options |
| `flake.nix` | Nix dependencies | Adding new flake inputs |
| `formatter.nix` | Code formatting rules | Changing formatter settings |

## Build/Test/Lint Commands

```bash
nix build .#avim      # Build the package
nix run .#avim        # Run avim directly
nix flake check       # Verify flake and run checks
nix fmt               # Format all code (deadnix, nixfmt, statix, shfmt, stylua, yamlfmt)
rm -rf result*        # Clean build artifacts
```

## Common Tasks

### Adding a Plugin

In `packages/avim/config.nix` under the `plugins` attribute:

```nix
plugins = {
  # Simple enable
  plugin-name.enable = true;

  # With configuration
  plugin-name = {
    enable = true;
    settings = {
      option1 = true;
      option2 = "value";
    };
  };
};
```

### Adding a Keymap

```nix
keymaps = [
  {
    mode = "n";  # n=normal, v=visual, i=insert, t=terminal
    key = "<leader>xx";
    action = "<cmd>SomeCommand<cr>";
    options.desc = "Description for which-key";
  }
];
```

### Adding an LSP Server

```nix
plugins.lsp.servers = {
  servername = {
    enable = true;
    # Optional: server-specific settings
    settings = { };
  };
};
```

### Adding a Treesitter Grammar

```nix
plugins.treesitter = {
  grammarPackages = with pkgs.vimPlugins.nvim-treesitter.builtGrammars; [
    existing-grammars
    new-grammar
  ];
};
```

### Using Lua in Nix

For inline Lua code, use `__raw`:

```nix
# Simple expression
action.__raw = "vim.lsp.buf.definition";

# Function
action.__raw = ''
  function()
    vim.notify("Hello from Lua")
  end
'';

# Complex callback
settings.on_attach.__raw = ''
  function(client, bufnr)
    -- setup code here
  end
'';
```

### Adding a Formatter

In `plugins.conform-nvim.settings.formatters_by_ft`:

```nix
formatters_by_ft = {
  language = ["formatter1" "formatter2"];
};
```

## Code Style Guidelines

### Nix Files

- **Indentation**: 2 spaces
- **Variables**: camelCase (e.g., `myVariable`)
- **Attributes**: kebab-case (e.g., `my-package`)
- **Imports**: Use `with pkgs;` for package lists
- **Comments**: Minimal, only when logic isn't obvious

### Lua in `__raw` Blocks

- **Indentation**: 2 spaces
- **Strings**: Use `''` (Nix multi-line) to avoid escaping

### Keymaps

- Always include `options.desc` for which-key discoverability
- Group related keymaps together
- Use consistent prefixes (`<leader>f` for find, `<leader>g` for git, etc.)

## Anti-patterns to Avoid

| Don't | Do Instead |
|-------|------------|
| Use `vim.cmd` for things Nixvim handles | Use declarative Nixvim options |
| Hardcode paths | Use Nix derivations and `pkgs` |
| Add keymaps without descriptions | Always set `options.desc` |
| Mix tabs and spaces | Use 2 spaces consistently |
| Skip formatting before commit | Always run `nix fmt` |

## Testing Changes

1. **Format**: `nix fmt`
2. **Check**: `nix flake check`
3. **Build**: `nix build .#avim`
4. **Test**: `nix run .#avim` and verify functionality manually

## Dependencies

This project uses:

- **Nixvim**: Declarative Neovim configuration
- **Blueprint**: Nix flake organization framework
- **treefmt-nix**: Multi-language code formatting
- **devshell**: Development environment management
