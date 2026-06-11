# AGENTS.md - LLM Development Guide

## Project Overview

avim.nix is a reproducible Neovim configuration built with Nixvim. All configuration is declarative Nix - no imperative Lua files. The entire editor setup is defined in Nix expressions that compile to a working Neovim installation.

## Architecture

```
avim.nix/
├── flake.nix                 # Flake inputs and Blueprint configuration
├── formatter.nix             # treefmt-nix setup
├── devshell.nix              # Development environment
├── checks/
│   ├── avim-startup.nix      # Headless nvim startup smoke test
│   └── readme-keymaps.nix    # Fails when README keybindings drift from config.nix
├── packages/avim/
│   ├── default.nix           # Package wrapper script (rarely modified)
│   ├── config.nix            # Main config: options, plugins, keymaps
│   └── VERSION               # Package version — owned by the release workflow
└── packages/docs/
    ├── default.nix           # `nix run .#docs` — regenerates README keybindings
    └── keymaps-md.nix        # Renders keymaps + which-key groups to markdown
```

## Key Files

| File | Purpose | When to Modify |
|------|---------|----------------|
| `packages/avim/config.nix` | All Neovim configuration | Adding plugins, keymaps, LSP servers, options |
| `flake.nix` | Nix dependencies | Adding new flake inputs |
| `formatter.nix` | Code formatting rules | Changing formatter settings |
| `packages/avim/VERSION` | Package version | Never by hand — the release workflow writes it |
| `README.md` keybindings section | Generated docs | Never by hand — run `nix run .#docs` |

## Build/Test/Lint Commands

```bash
nix build .#avim      # Build the package
nix run .#avim        # Run avim directly
nix flake check       # Verify flake and run all checks (startup test, README sync, ...)
nix fmt               # Format all code (deadnix, nixfmt, statix, shfmt, stylua, yamlfmt)
nix run .#docs        # Regenerate the README keybindings section from config.nix
rm -rf result*        # Clean build artifacts
```

## CI, Auto-merge, and Releases

- **CI is a single required check**: the `nix-flake-check` GitHub Actions workflow runs
  `nix flake check`, which builds the package and all `checks/` (including the headless
  startup test and the README-sync check). There is no other CI (Garnix was removed).
- **Mergify auto-merges PRs** labeled `merge-queue` or `dependencies` once
  `nix-flake-check` passes (`.mergify.yml`, rebase method). Label a PR `merge-queue`
  and it merges itself in a few minutes — no manual merging needed.
- **Weekly automation**: `auto-update.yaml` (Sunday 00:00 UTC) opens a single
  `nix flake update` PR labeled `dependencies`; `release.yaml` (Monday 00:00 UTC)
  refuses to run if update PRs are still open, bumps `packages/avim/VERSION` to
  calver (`YYYY.MM.DD.N`), runs `nix flake check`, tags `vYYYY.MM.DD.N`, and
  publishes a GitHub release. Both can be triggered manually via `workflow_dispatch`.
- GitHub Actions in workflows are pinned to commit SHAs — keep it that way when
  touching workflows, and pass dynamic values through `env:` blocks, never inline
  `${{ }}` in `run:` scripts.

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

- Always include `options.desc` for which-key discoverability — it is also the text
  shown in the generated README tables, and keymaps without a desc are omitted from them
- Group related keymaps together
- Use consistent prefixes (`<leader>f` for find, `<leader>g` for git, etc.)
- After any keymap change, run `nix run .#docs` and commit the regenerated README —
  the `readme-keymaps` check fails CI otherwise

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
2. **Docs** (if keymaps changed): `nix run .#docs`
3. **Check**: `nix flake check` (includes the headless startup test and README-sync check)
4. **Build**: `nix build .#avim`
5. **Test**: `nix run .#avim` and verify functionality manually

## Conventions Learned

- Formatter binaries used by conform (`prettier`, `stylua`, `gofumpt`, ...) and tools
  used by keymaps (`lazygit`) are bundled via `extraPackages` in `config.nix` — if a
  keymap or formatter needs a binary, add it there rather than assuming the host has it.
  `terraform` is deliberately not bundled (unfree license).
- This nixpkgs has `nodePackages` removed — use top-level attrs (e.g. `prettier`).
- The repo prefers removing unused code/config outright over `enable = false` stubs.

## Dependencies

This project uses:

- **Nixvim**: Declarative Neovim configuration
- **Blueprint**: Nix flake organization framework
- **treefmt-nix**: Multi-language code formatting
- **devshell**: Development environment management
