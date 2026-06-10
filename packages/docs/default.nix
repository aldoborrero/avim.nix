{ pkgs, ... }:
let
  keymapsMd = import ./keymaps-md.nix { inherit pkgs; };
in
pkgs.writeShellApplication {
  name = "docs";
  runtimeInputs = [ pkgs.gawk ];
  text = ''
    readme="README.md"
    if [ ! -f "$readme" ]; then
      echo "error: run from the repository root" >&2
      exit 1
    fi
    awk -v md="${keymapsMd}" '
      /<!-- keymaps:start -->/ {
        print
        while ((getline line < md) > 0) print line
        skip = 1
        next
      }
      /<!-- keymaps:end -->/ { skip = 0 }
      !skip { print }
    ' "$readme" > "$readme.tmp"
    mv "$readme.tmp" "$readme"
    echo "README.md keybindings section regenerated"
  '';
}
