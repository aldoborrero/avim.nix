# Renders the keybindings tables for README.md from the keymaps and
# which-key groups declared in packages/avim/config.nix.
{ pkgs }:
let
  inherit (pkgs) lib;
  config = import ../avim/config.nix { inherit pkgs; };

  groups = map (g: {
    prefix = g."__unkeyed-1";
    name = g.group;
  }) config.plugins.which-key.settings.spec;

  modeNames = {
    n = "Normal";
    v = "Visual";
    x = "Visual";
    i = "Insert";
    t = "Terminal";
    o = "Operator";
    s = "Select";
  };
  modeOf =
    km:
    let
      m = km.mode or "n";
      ms = if builtins.isList m then m else [ m ];
    in
    lib.concatStringsSep ", " (lib.unique (map (x: modeNames.${x} or x) ms));

  esc = s: lib.replaceStrings [ "|" ] [ "\\|" ] s;

  groupFor =
    km:
    let
      matches = lib.filter (g: lib.hasPrefix g.prefix km.key) groups;
      best = lib.head (lib.sort (a: b: lib.stringLength a.prefix > lib.stringLength b.prefix) matches);
    in
    if matches != [ ] then
      best.name
    else if lib.hasPrefix "<leader>" km.key then
      "Other Leader"
    else
      "General";

  described = lib.filter (km: (km.options.desc or "") != "") config.keymaps;

  groupNames = (map (g: g.name) groups) ++ [
    "Other Leader"
    "General"
  ];

  rows =
    name:
    lib.concatMapStrings (km: "| `${esc km.key}` | ${modeOf km} | ${esc km.options.desc} |\n") (
      lib.filter (km: groupFor km == name) described
    );

  section =
    name:
    let
      r = rows name;
    in
    lib.optionalString (r != "") (
      "### "
      + name
      + "\n\n"
      + "| Key | Mode | Description |\n"
      + "|-----|------|-------------|\n"
      + r
      + "\n"
    );

  markdown =
    "<!-- Generated from packages/avim/config.nix by `nix run .#docs` — do not edit by hand. -->\n\n"
    + "> **Note**: Leader key is `<Space>`, Local leader is `,`\n\n"
    + lib.concatMapStrings section groupNames;
in
pkgs.writeText "keymaps.md" markdown
