{ pkgs, inputs, ... }:
inputs.nixvim.lib.${pkgs.stdenv.hostPlatform.system}.check.mkTestDerivationFromNixvimModule {
  inherit pkgs;
  module = import ../packages/avim/config.nix { inherit pkgs inputs; };
}
