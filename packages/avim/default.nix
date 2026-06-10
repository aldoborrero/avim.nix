{
  pkgs,
  inputs,
  ...
}:
with pkgs;
let
  nvim-appname = "avim";
  version = lib.trim (builtins.readFile ./VERSION);

  nvim = inputs.nixvim.legacyPackages.${pkgs.stdenv.hostPlatform.system}.makeNixvimWithModule {
    inherit pkgs;
    module = import ./config.nix { inherit pkgs inputs; };
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
      homepage = "https://github.com/aldoborrero/avim.nix";
      license = lib.licenses.mit;
    };
  });
in
package
