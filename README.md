# AstroNvim.nix

My [AstroNvim](https://astronvim.com/) configuration with Nix!

## Why?

Having my configuration ready as a `flake` allows me to run `nvim` already configured to my taste wherever I want!

**Note**: This is a personal configuration tailored to my specific needs. Feel free to fork this repository and customize on your own!

## Setup

### [Optional] Add flake registry shortcut

You can add the following registry shortcut to type less characters:

```console
$ nix registry add astronvim github:aldoborrero/astronvim.nix
```

## Running AstroNvim

```console
$ nix run astronvim#astronvim
```

## Acknowledgements

Thanks to mighty @Mic92 to whom I took inspiration (and stole majority of his code) from his [dotfiles](https://github.com/mic92/dotfiles) repository!

## License

See [License](License) for more information.
