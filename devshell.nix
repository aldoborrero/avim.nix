{
  pkgs,
  ...
}:
pkgs.mkShellNoCC {
  shellHook = ''
    export NIX_PATH="nixpkgs=${pkgs.path}"
  '';
}
