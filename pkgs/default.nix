{
  perSystem = {
    pkgs,
    self',
    myPkgs,
    inputs',
    ...
  }: {
    packages = rec {
      astronvim4-config = pkgs.callPackage ./astronvim4/config.nix {inherit myPkgs;};
      astronvim4 = pkgs.callPackage ./astronvim4 {inherit astronvim4-config;};

      astronvim = astronvim4;

      avim = let
        nixvim' = inputs'.nixvim.legacyPackages;
      in
        pkgs.callPackage ./avim {
          inherit (nixvim') makeNixvimWithModule;
        };
    };

    overlayAttrs = self'.packages;
  };
}
