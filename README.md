# avim.nix

My custom Neovim configuration built with [Nixvim](https://github.com/nix-community/nixvim)!

## Why?

Having my Neovim configuration ready as a `flake` allows me to run `nvim` already configured to my taste wherever I want with full reproducibility.

**Note**: This is a personal configuration tailored to my specific needs. Feel free to fork this repository and customize on your own!

## Features

- **Nix Integration**: Fully reproducible Neovim setup using [Nixvim](https://github.com/nix-community/nixvim)
- **Blueprint Structure**: Uses the [Blueprint](https://github.com/numtide/blueprint) framework for organizing Nix code
- **Automatic Updates**: Weekly scheduled updates for dependencies

## Setup

### [Optional] Add flake registry shortcut

You can add the following registry shortcut to type less characters:

```console
$ nix registry add avim github:aldoborrero/avim.nix
```

## Running avim

```console
$ nix run avim#avim
```

## Keybindings

<!-- keymaps:start -->
<!-- Generated from packages/avim/config.nix by `nix run .#docs` — do not edit by hand. -->

> **Note**: Leader key is `<Space>`, Local leader is `,`

### Find

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ff` | Normal | Find files |
| `<leader>fF` | Normal | Find all files |
| `<leader>fg` | Normal | Find git files |
| `<leader>fw` | Normal | Find words |
| `<leader>fW` | Normal | Find words in all files |
| `<leader>fb` | Normal | Find buffers |
| `<leader>fh` | Normal | Find help |
| `<leader>fo` | Normal | Find old files |
| `<leader>fO` | Normal | Find old files (cwd) |
| `<leader>fc` | Normal | Find word under cursor |
| `<leader>fC` | Normal | Find commands |
| `<leader>fk` | Normal | Find keymaps |
| `<leader>fm` | Normal | Find man |
| `<leader>f'` | Normal | Find marks |
| `<leader>fr` | Normal | Find registers |
| `<leader>ft` | Normal | Find themes |
| `<leader>fs` | Normal | Find buffers/recent/files |
| `<leader>fp` | Normal | Find projects |
| `<leader>fn` | Normal | Find notifications |
| `<leader>f<CR>` | Normal | Resume previous search |
| `<leader>fl` | Normal | Find lines |
| `<leader>fu` | Normal | Find undo history |

### Search

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>sr` | Normal | Search and replace |
| `<leader>sw` | Normal | Search current word |
| `<leader>sw` | Visual | Search selected text |
| `<leader>sp` | Normal | Search in current file |
| `<leader>st` | Normal | Search todo comments |

### Session/Quit

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>qq` | Normal | Quit Neovim |
| `<leader>qs` | Normal | Save session |
| `<leader>ql` | Normal | Load last session |
| `<leader>qd` | Normal | Stop session tracking |
| `<leader>qr` | Normal | Restore last session |

### Git

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>gb` | Normal | Git branches |
| `<leader>gc` | Normal | Git commits (repository) |
| `<leader>gC` | Normal | Git commits (current file) |
| `<leader>gt` | Normal | Git status |
| `<leader>gT` | Normal | Git stash |
| `<leader>go` | Normal | Git browse (open) |
| `<leader>go` | Visual | Git browse (open) |
| `<leader>gd` | Normal | Open Diffview |
| `<leader>gh` | Normal | File history |
| `<leader>gH` | Normal | Current file history |
| `<leader>gq` | Normal | Close Diffview |
| `<leader>gg` | Normal | Open LazyGit |

### LSP

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>la` | Normal | Code action |
| `<leader>lr` | Normal | Rename symbol |
| `<leader>lf` | Normal | Format buffer |
| `<leader>lf` | Visual | Format selection |
| `<leader>lh` | Normal | Signature help |
| `<leader>li` | Normal | LSP info |
| `<leader>lR` | Normal | Restart LSP |
| `<leader>lD` | Normal | Search diagnostics |
| `<leader>lw` | Normal | Workspace symbols |
| `<leader>ld` | Normal | Show line diagnostics |
| `<leader>lq` | Normal | Diagnostic quickfix |

### UI/Utils

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>u\|` | Normal | Toggle indent guides |
| `<leader>uD` | Normal | Dismiss notifications |
| `<leader>uZ` | Normal | Toggle zen mode |
| `<leader>uf` | Normal | Toggle auto-format |
| `<leader>uu` | Normal | Toggle undotree |

### Harpoon

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>ha` | Normal | Harpoon add file |
| `<leader>hh` | Normal | Harpoon quick menu |
| `<leader>h1` | Normal | Harpoon file 1 |
| `<leader>h2` | Normal | Harpoon file 2 |
| `<leader>h3` | Normal | Harpoon file 3 |
| `<leader>h4` | Normal | Harpoon file 4 |
| `<leader>h5` | Normal | Harpoon file 5 |
| `<leader>h6` | Normal | Harpoon file 6 |
| `<leader>h7` | Normal | Harpoon file 7 |
| `<leader>h8` | Normal | Harpoon file 8 |
| `<leader>h9` | Normal | Harpoon file 9 |
| `<leader>hn` | Normal | Harpoon next |
| `<leader>hp` | Normal | Harpoon previous |
| `<leader>hd` | Normal | Remove current file from Harpoon |
| `<leader>hc` | Normal | Clear all Harpoon marks |

### Quick Actions

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>xr` | Normal | Reload file from disk |
| `<leader>xy` | Normal | Copy entire buffer to clipboard |
| `<leader>xs` | Normal | Save file |
| `<leader>xS` | Normal | Save all files |
| `<leader>xw` | Normal | Toggle word wrap |
| `<leader>xp` | Normal | Show full file path |
| `<leader>xe` | Normal | Make file executable |

### Other Leader

| Key | Mode | Description |
|-----|------|-------------|
| `<leader>n` | Normal | New file |
| `<leader>e` | Normal | Toggle file explorer |
| `<leader>o` | Normal | Toggle Explorer Focus |
| `<leader>H` | Normal | Home Screen |
| `<leader><leader>` | Normal | Find files |
| `<leader>/` | Normal | Toggle comment |
| `<leader>/` | Visual | Toggle comment |

### General

| Key | Mode | Description |
|-----|------|-------------|
| `jk` | Insert | Exit insert mode |
| `<C-h>` | Normal | Navigate left |
| `<C-j>` | Normal | Navigate down |
| `<C-k>` | Normal | Navigate up |
| `<C-l>` | Normal | Navigate right |
| `]b` | Normal | Next buffer |
| `[b` | Normal | Previous buffer |
| `<C-s>` | Normal | Save file |
| `<Esc>` | Normal | Clear search highlights |
| `\|` | Normal | Vertical split |
| `\` | Normal | Horizontal split |
| `s` | Normal, Visual, Operator | Flash jump |
| `S` | Normal, Operator | Flash treesitter |
| `r` | Operator | Remote Flash |
| `R` | Operator, Visual | Flash treesitter search |
| `]t` | Normal | Next todo comment |
| `[t` | Normal | Previous todo comment |
| `gd` | Normal | Go to definition |
| `gD` | Normal | Go to declaration |
| `gi` | Normal | Go to implementation |
| `gr` | Normal | Show references |
| `gt` | Normal | Go to type definition |
| `K` | Normal | Hover documentation |
| `]d` | Normal | Next diagnostic |
| `[d` | Normal | Previous diagnostic |
| `gp` | Normal | Preview definition |
| `<Esc><Esc>` | Terminal | Exit terminal mode |
| `<F9>` | Normal | Toggle terminal 1 |
| `<F9>` | Terminal | Toggle terminal 1 |
| `<F10>` | Normal | Toggle terminal 2 |
| `<F10>` | Terminal | Toggle terminal 2 |
| `<F11>` | Normal | Toggle terminal 3 |
| `<F11>` | Terminal | Toggle terminal 3 |
| `<F12>` | Normal | Toggle terminal 4 |
| `<F12>` | Terminal | Toggle terminal 4 |
| `<C-l>` | Insert, Select | Luasnip jump next |
| `<C-h>` | Insert, Select | Luasnip jump prev |

<!-- keymaps:end -->

## Acknowledgements

Thanks to mighty @Mic92 to whom I took inspiration (and stole majority of his code) from his [dotfiles](https://github.com/mic92/dotfiles) repository!

## License

See [LICENSE](LICENSE) for more information.
