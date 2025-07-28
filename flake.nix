{
  description = "astronvim.nix / My personal astronvim configuration";

  nixConfig = {
    extra-substituters = [
      "https://nix-community.cachix.org"
      "https://numtide.cachix.org"
      "https://cache.garnix.io"
    ];
    extra-trusted-public-keys = [
      "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      "numtide.cachix.org-1:2ps1kLBUWjxIneOy1Ik6cQjb41X0iXVXeHigGmycPPE="
      "cache.garnix.io:CTFPyKSLcx5RMJKfLo5EEPUObbA78b0YQ2DTCJXqr9g="
    ];
  };

  inputs = {
    # nix packages
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-unstable.url = "github:nixos/nixpkgs/nixpkgs-unstable";
    mynixpkgs.url = "github:aldoborrero/mynixpkgs";

    # flake-parts
    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    # utils
    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    devshell = {
      url = "github:numtide/devshell";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    lib-extras = {
      url = "github:aldoborrero/lib-extras";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    systems.url = "github:nix-systems/default";
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ {
    flake-parts,
    lib-extras,
    nixpkgs-unstable,
    ...
  }: let
    lib = nixpkgs-unstable.lib.extend (l: _: lib-extras.lib l);
  in
    flake-parts.lib.mkFlake
    {
      inherit inputs;
      specialArgs = {inherit lib;};
    }
    {
      imports = [
        inputs.devshell.flakeModule
        inputs.flake-parts.flakeModules.easyOverlay
        inputs.treefmt-nix.flakeModule
        ./pkgs
      ];

      debug = false;

      systems = import inputs.systems;

      perSystem = {system, ...}: {
        # packages
        _module.args = {
          pkgs = lib.nix.mkNixpkgs {
            inherit system;
            inherit (inputs) nixpkgs;
          };
          pkgsUnstable = lib.nix.mkNixpkgs {
            inherit system;
            nixpkgs = inputs.nixpkgs-unstable;
          };
          myPkgs = inputs.mynixpkgs.packages.${system};
        };

        # devshell
        devshells.default = {
          name = "astronvim.nix";
          packages = [];
          commands = [
            {
              name = "clean";
              category = "Nix";
              help = "Cleans any result produced by Nix or associated tools";
              command = ''rm -rf repl-result* result* *.qcow2'';
            }

            {
              category = "Nix";
              name = "fmt";
              help = "Format the source tree";
              command = "nix fmt";
            }

            {
              category = "Nix";
              name = "check";
              help = "Check the source tree";
              command = "nix flake check";
            }
          ];
        };

        # formatter
        treefmt.config = {
          flakeFormatter = true;
          flakeCheck = true;
          projectRootFile = "flake.nix";
          programs = {
            alejandra.enable = true;
            deadnix.enable = true;
            mdformat.enable = true;
            shellcheck.enable = true;
            shfmt.enable = true;
            statix.enable = true;
            stylua.enable = true;
            yamlfmt.enable = true;
          };
          settings.formatter = {
            alejandra.priority = 3;
            deadnix.priority = 1;
            statix.priority = 2;
          };
        };
      };
    };
}
