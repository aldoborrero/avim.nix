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

## Acknowledgements

Thanks to mighty @Mic92 to whom I took inspiration (and stole majority of his code) from his [dotfiles](https://github.com/mic92/dotfiles) repository!

## License

See [License](License) for more information.
