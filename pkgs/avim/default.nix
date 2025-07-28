{
  makeNixvimWithModule,
  nvim-appname ? "avim",
  pkgs,
  writeShellScriptBin,
}: let
  # Build the nixvim derivation using the standalone builder
  nvim = makeNixvimWithModule {
    inherit pkgs;
    module = import ./config.nix;
  };

  # Create wrapper script
  avimWrapper = writeShellScriptBin "avim" ''
    export NVIM_APPNAME="${nvim-appname}"

    # Ensure config directory exists
    CONFIG_DIR="''${XDG_CONFIG_HOME:-$HOME/.config}/$NVIM_APPNAME"
    mkdir -p "$CONFIG_DIR"

    # Launch neovim with nixvim configuration
    exec ${nvim}/bin/nvim "$@"
  '';
in
  avimWrapper
