{
  pkgs,
  perSystem,
  ...
}:
perSystem.devshell.mkShell {
  name = "astronvim.nix";
  packages = [ ];
  env = [
    {
      name = "NIX_PATH";
      eval = "nixpkgs=${pkgs.path}";
    }
  ];
  commands = [
    {
      name = "fmt";
      category = "Formatters";
      help = "Format the source tree";
      command = ''nix fmt'';
    }
    {
      name = "clean";
      category = "Utils";
      help = "Cleans any result produced by Nix or associated tools";
      command = "rm -rf result* *.qcow2 *.fd";
    }
  ];
}
