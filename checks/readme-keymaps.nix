# Fails when the README keybindings section is out of sync with the
# keymaps declared in packages/avim/config.nix. Fix with: nix run .#docs
{ pkgs, ... }:
let
  keymapsMd = import ../packages/docs/keymaps-md.nix { inherit pkgs; };
in
pkgs.runCommand "readme-keymaps" { nativeBuildInputs = [ pkgs.gawk ]; } ''
  awk '/<!-- keymaps:start -->/{f=1;next} /<!-- keymaps:end -->/{f=0} f' \
    ${../README.md} > committed
  if ! diff -u committed ${keymapsMd}; then
    echo
    echo "README keybindings section is stale; run: nix run .#docs"
    exit 1
  fi
  touch $out
''
