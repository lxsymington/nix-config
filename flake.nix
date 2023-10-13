{
  description = "System configurations";

  inputs = {
    darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:lnl7/nix-darwin";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    stable.url = "github:nixos/nixpkgs/nixos-21.11";
    lsp-nil = {
      url = "github:oxalica/nil";
    };
    nix-vscode-extensions = {
      url = "github:nix-community/nix-vscode-extensions";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager, lsp-nil, ... }@inputs:
    let
      inherit (darwin.lib) darwinSystem;
      inherit (home-manager.lib) homeManagerConfiguration;
      inherit (builtins) elem;

      isDarwin = system: (elem system nixpkgs.lib.platforms.darwin);
      homePrefix = system: if isDarwin system then "/Users" else "/home";

      # generate a base darwin configuration with the specified hostname,
      # overlays and any extraModules applied
      mkDarwinConfig =
        { system ? "aarch64-darwin"
        , nixpkgs ? inputs.nixpkgs
        , stable ? inputs.stable
        , baseModules ? [
            home-manager.darwinModules.home-manager
            ./modules/darwin
          ]
        , extraModules ? []
        }: darwinSystem {
          inherit system;
          pkgs = import nixpkgs {
            inherit system;
            config = {
              allowUnsupportedSystem = true;
              allowUnfree = true;
              allowBroken = false;
            };
            overlays = [
              (final: prev: {
                rnix-lsp = lsp-nil.packages.${final.system}.default;
              })
            ];
          };
          modules = baseModules ++ extraModules;
          specialArgs = { inherit self inputs nixpkgs stable; };
        };

      # generate a home-manager configuration usable on any unix system
      # with overlays and any extraModules applied
      mkHomeConfig = {
        username,
        system ? "x86_64-linux",
        nixpkgs ? inputs.nixpkgs,
        stable ? inputs.stable,
        baseModules ? [
          ./modules/home-manager
          {
            home = {
              inherit username;
              homeDirectory = "${homePrefix system}/${username}";
              sessionVariables = {
                NIX_PATH =
                  "nixpkgs=${nixpkgs}:stable=${stable}\${NIX_PATH:+:}$NIX_PATH";
              };
            };
          }
        ],
        extraModules ? [ ]
      }: homeManagerConfiguration {
        pkgs = import nixpkgs {
          inherit system;
          config = {
            allowUnsupportedSystem = true;
            allowUnfree = true;
            allowBroken = false;
          };
          overlays = [
            (final: prev: {
              rnix-lsp = lsp-nil.defaultPackagae.${final.system};
            })
          ];
        };
        modules = baseModules ++ extraModules;
        specialArgs = { inherit self inputs nixpkgs stable; };
      };
    in
    {
      darwinConfigurations = {
        Lukes-MacBook-Pro = mkDarwinConfig {
          extraModules = [
            ./modules/darwin/work.nix
            ./profiles/lxs-work.nix
          ];
        };
        josie-personal-macbook = mkDarwinConfig {
          system = "x86_64-darwin";
          extraModules = [
            ./profiles/lxs-personal.nix
          ];
        };
      };

      homeConfigurations = {
        lxs = mkHomeConfig {
          username = "lxs";
          extraModules = [ ];
        };
      };
    };
}
