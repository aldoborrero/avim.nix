{
  astronvim4-config,
  buildEnv,
  lib,
  neovim,
  nvim-appname ? "astronvim4",
  vimPlugins,
  writeShellScriptBin,
}: let
  common = import ./lib.nix {
    inherit lib neovim buildEnv writeShellScriptBin;
  };
in
  common.mkAstronvimWrapper {
    name = "astronvim4";
    config = astronvim4-config;
    inherit nvim-appname;
    postInit = ''
      # Link telescope-fzf-native plugin (v4 specific)
      if [[ -d $NVIM_DATA/lazy/telescope-fzf-native.nvim ]]; then
        [[ $VERBOSE -eq 1 ]] && echo "Linking telescope-fzf-native binary..."
        mkdir -p "$NVIM_DATA/lazy/telescope-fzf-native.nvim/build"
        ln -sf "${vimPlugins.telescope-fzf-native-nvim}/build/libfzf.so" "$NVIM_DATA/lazy/telescope-fzf-native.nvim/build/libfzf.so"
      fi
    '';
  }
