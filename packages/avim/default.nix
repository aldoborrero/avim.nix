{
  pkgs,
  inputs,
  ...
}:
with pkgs;
let
  nvim-appname = "avim";
  version = "2025.09.21.0";

  nvim = inputs.nixvim.legacyPackages.${pkgs.system}.makeNixvimWithModule {
    inherit pkgs;
    module = import ./config.nix;
  };

  avimWrapper = writeShellScriptBin "avim" ''
    export NVIM_APPNAME="${nvim-appname}"

    # Ensure config directory exists
    CONFIG_DIR="''${XDG_CONFIG_HOME:-$HOME/.config}/$NVIM_APPNAME"
    mkdir -p "$CONFIG_DIR"

    # Launch neovim with nixvim configuration
    exec ${nvim}/bin/nvim "$@"
  '';

  package = avimWrapper.overrideAttrs (old: {
    inherit version;
    meta = (old.meta or { }) // {
      description = "Avim - Custom Neovim configuration";
      homepage = "https://github.com/aldoborrero/astronvim.nix";
      license = lib.licenses.mit;
    };
  });
in
package
