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
$ nix registry add avim github:aldoborrero/astronvim.nix
```

## Running avim

```console
$ nix run avim#avim
```

## Keybindings

> **Note**: Leader key is `<Space>`, Local leader is `,`

### Navigation

| Key | Action | Description |
|-----|--------|-------------|
| `<C-h>` | Navigate left | Move to left window |
| `<C-j>` | Navigate down | Move to window below |
| `<C-k>` | Navigate up | Move to window above |
| `<C-l>` | Navigate right | Move to right window |
| `]b` | Next buffer | Switch to next buffer |
| `[b` | Previous buffer | Switch to previous buffer |
| `s` | Flash jump | Jump to location with flash.nvim |
| `S` | Flash treesitter | Jump with treesitter nodes |

### File Management

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>e` | Toggle file explorer | Toggle Neo-tree |
| `<leader>o` | Focus explorer | Toggle Neo-tree focus |
| `<leader><leader>` | Find files | Quick file picker |
| `<leader>ff` | Find files | Find files in project |
| `<leader>fF` | Find all files | Find all files (including hidden) |
| `<leader>fg` | Find git files | Find git tracked files |
| `<leader>fw` | Find words | Search for words in project |
| `<leader>fW` | Find words (all) | Search in all files |
| `<leader>fb` | Find buffers | Search open buffers |
| `<leader>fo` | Find old files | Recent files |
| `<leader>fO` | Find old files (cwd) | Recent files in current directory |
| `<leader>fa` | Find config files | Search config files |
| `<leader>fh` | Find help | Search help tags |
| `<leader>fc` | Find word under cursor | Search current word |
| `<leader>fC` | Find commands | Search available commands |
| `<leader>fk` | Find keymaps | Search keymaps |
| `<leader>fm` | Find man pages | Search manual pages |
| `<leader>f'` | Find marks | Search marks |
| `<leader>fr` | Find registers | Search registers |
| `<leader>ft` | Find themes | Search colorschemes |
| `<leader>fs` | Find smart | Smart buffer/recent/files |
| `<leader>fp` | Find projects | Search projects |
| `<leader>fn` | Find notifications | Search notifications |
| `<leader>fl` | Find lines | Search lines in buffer |
| `<leader>fu` | Find undo history | Browse undo tree |
| `<leader>f<CR>` | Resume search | Resume previous search |

### Git Operations

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>gb` | Git branches | Browse branches |
| `<leader>gc` | Git commits | Repository commit history |
| `<leader>gC` | Git commits (file) | Current file commit history |
| `<leader>gt` | Git status | Show git status |
| `<leader>gT` | Git stash | Browse stash |
| `<leader>go` | Git browse | Open in browser |
| `<leader>gd` | Open Diffview | Open diff viewer |
| `<leader>gh` | File history | View file history |
| `<leader>gH` | Current file history | View current file history |
| `<leader>gq` | Close Diffview | Close diff viewer |
| `<leader>gg` | LazyGit | Open LazyGit |

### LSP (Language Server)

| Key | Action | Description |
|-----|--------|-------------|
| `gd` | Go to definition | Jump to definition |
| `gD` | Go to declaration | Jump to declaration |
| `gi` | Go to implementation | Jump to implementation |
| `gr` | Show references | Show references |
| `K` | Hover documentation | Show hover info |
| `<leader>la` | Code action | Show code actions |
| `<leader>lr` | Rename symbol | Rename symbol |
| `<leader>lf` | Format buffer | Format code |
| `<leader>lD` | Search diagnostics | Search diagnostics |
| `<leader>ls` | Search symbols | Search LSP symbols |

### Search and Replace

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>sr` | Search and replace | Open Spectre |
| `<leader>sw` | Search current word | Search and replace current word |
| `<leader>sp` | Search in file | Search and replace in current file |

### UI/Utils

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>u\|` | Toggle indent guides | Toggle indent guides |
| `<leader>uD` | Dismiss notifications | Clear all notifications |
| `<leader>uZ` | Toggle zen mode | Toggle zen mode |
| `<leader>uu` | Toggle undotree | Toggle undo tree |
| `<leader>H` | Home screen | Toggle dashboard |

### Terminal and AI

| Key | Action | Description |
|-----|--------|-------------|
| `<F4>` | Open Claude Code | Open Claude Code AI assistant |
| `<F5>` | Continue conversation | Continue Claude Code conversation |
| `<F6>` | Open LazyGit | Open LazyGit in terminal |
| `<F7>` | Toggle terminal | Toggle floating terminal |
| `<Esc><Esc>` | Exit terminal mode | Exit to normal mode (in terminal) |

### Window Management

| Key | Action | Description |
|-----|--------|-------------|
| `\|` | Vertical split | Create vertical split |
| `\` | Horizontal split | Create horizontal split |

### Harpoon

| Key | Action | Description |
|-----|--------|-------------|
| `<leader>ha` | Harpoon add file | Add file to harpoon |
| `<leader>hh` | Harpoon menu | Toggle harpoon menu |
| `<leader>h1-9` | Jump to file 1-9 | Jump to harpoon file |
| `<leader>hn` | Next file | Jump to next harpoon file |
| `<leader>hp` | Previous file | Jump to previous harpoon file |
| `<leader>hd` | Remove file | Remove file from harpoon |
| `<leader>hc` | Clear marks | Clear all harpoon marks |

### Todo Comments

| Key | Action | Description |
|-----|--------|-------------|
| `]t` | Next todo | Jump to next todo comment |
| `[t` | Previous todo | Jump to previous todo comment |
| `<leader>st` | Search todos | Search todo comments |

### Editing

| Key | Action | Description |
|-----|--------|-------------|
| `<C-s>` | Save file | Save current file |
| `<Esc>` | Clear highlights | Clear search highlights |
| `<leader>/` | Toggle comment | Toggle comment (line/selection) |

## Acknowledgements

Thanks to mighty @Mic92 to whom I took inspiration (and stole majority of his code) from his [dotfiles](https://github.com/mic92/dotfiles) repository!

## License

See [License](License) for more information.
