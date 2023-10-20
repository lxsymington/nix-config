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
      homeDirectory = { system, username }: "${homePrefix system}/${username}";

      nixpkgsWithOverlays = system: (import nixpkgs {
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
      });
      
      # generate a base darwin configuration with the specified hostname,
      # overlays and any extraModules applied
      mkDarwinConfig = {
        system ? "aarch64-darwin",
        username,
        extraModules ? []
      }: darwinSystem {
        inherit system;
        pkgs = nixpkgsWithOverlays system;
        modules = [
          home-manager.darwinModules.home-manager
          ./modules/darwin
        ] ++ extraModules;
        specialArgs = {
          inherit self inputs username;
          homeDirectory = homeDirectory {
            inherit system username;
          };
        };
      };

      # generate a home-manager configuration usable on any unix system
      # with overlays and any extraModules applied
      mkHomeConfig = {
        system ? "x86_64-linux",
        username,
        extraModules ? [ ]
      }: homeManagerConfiguration {
        pkgs = nixpkgsWithOverlays { inherit system; };
        modules = [
          ./modules/home-manager
          {
            home = {
              inherit username homeDirectory;
              sessionVariables = {
                NIX_PATH =
                  "nixpkgs=${inputs.nixpkgs}:stable=${inputs.stable}\${NIX_PATH:+:}$NIX_PATH";
              };
            };
          }
        ] ++ extraModules;
        specialArgs = {
          inherit self inputs username;
          homeDirectory = homeDirectory {
            inherit system username;
          };
        };
      };
    in
    {
      darwinConfigurations = {
        Lukes-MacBook-Pro = mkDarwinConfig {
          username = "lxs";
          extraModules = [
            ./modules/darwin/work.nix
            ./profiles/lxs-work.nix
          ];
        };
        josie-personal-macbook = mkDarwinConfig {
          system = "x86_64-darwin";
          username = "lxs";
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
