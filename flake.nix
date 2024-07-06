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

    nix-index-database = {
      url = "github:Mic92/nix-index-database";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";

    nur = {
      url = "github:nix-community/NUR";
    };

    lsp-nil = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:oxalica/nil";
    };

    nix-vscode-extensions = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nix-vscode-extensions";
    };

    vscode-server = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nixos-vscode-server";
    };

    lxs-nvim = {
      url = "github:lxsymington/nix-neovim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    { darwin
    , home-manager
    , lsp-nil
    , nix-index-database
    , nixos-wsl
    , nixpkgs
    , nixpkgs-stable
    , nur
    , self
    , vscode-server
    , lxs-nvim
    , ...
    }@inputs:
    let
      inherit (nixpkgs.lib) nixosSystem;
      inherit (darwin.lib) darwinSystem;
      inherit (home-manager.lib) homeManagerConfiguration;
      inherit (builtins) elem;

      isDarwin = system: (elem system nixpkgs.lib.platforms.darwin);
      homePrefix = system: if isDarwin system then "/Users" else "/home";
      homeDirectory = { system, username }: "${homePrefix system}/${username}";

      nixpkgsWithOverlays = system: (import nixpkgs rec {
        inherit nixpkgs nixpkgs-stable system;
        config = {
          allowUnsupportedSystem = true;
          allowUnfree = true;
          allowBroken = false;
        };
        overlays = [
          nur.overlay
          (_final: prev: {
            # this allows us to reference pkgs.stable
            stable = import nixpkgs-stable {
              inherit (prev) system;
              inherit config;
            };
          })
          (final: prev: {
            rnix-lsp = lsp-nil.packages.${final.system}.default;
          })
          lxs-nvim.overlays.${system}.default
        ];
      });

      argDefaults = { hostname, system, username }: {
        inherit self hostname inputs nix-index-database username;
        homeDirectory = homeDirectory {
          inherit system username;
        };
        channels = {
          inherit nixpkgs nixpkgs-stable;
        };
      };

      mkNixosConfiguration =
        { system ? "x86_64-linux"
        , hostname
        , username
        , args ? { }
        , extraModules ? [ ]
        }:
        let
          specialArgs = argDefaults { inherit hostname system username; } // args;
        in
        nixosSystem {
          inherit system specialArgs;
          pkgs = nixpkgsWithOverlays system;
          modules = [
            home-manager.nixosModules.home-manager
            vscode-server.nixosModules.default
            ./modules/nixos
          ] ++ extraModules;
        };

      mkDarwinConfig =
        { system ? "aarch64-darwin"
        , hostname
        , username
        , args ? { }
        , extraModules ? [ ]
        }:
        let
          specialArgs = argDefaults { inherit hostname system username; } // args;
        in
        darwinSystem {
          inherit system specialArgs;
          pkgs = nixpkgsWithOverlays system;
          modules = [
            home-manager.darwinModules.home-manager
            ./modules/darwin
          ] ++ extraModules;
        };

      mkHomeConfig =
        { system ? "x86_64-linux"
        , hostname
        , username
        , args ? { }
        , extraModules ? [ ]
        }:
        let
          specialArgs = argDefaults { inherit hostname system username; } // args;
        in
        homeManagerConfiguration {
          inherit specialArgs;
          pkgs = nixpkgsWithOverlays { inherit system; };
          modules = [
            ./modules/home-manager
            {
              home = {
                inherit username homeDirectory;
                sessionVariables = {
                  NIX_PATH =
                    "nixpkgs=${nixpkgs}:stable=${nixpkgs-stable}\${NIX_PATH:+:}$NIX_PATH";
                };
              };
            }
          ] ++ extraModules;
        };
    in
    {
      nixosConfigurations = {
        nixos = mkNixosConfiguration {
          hostname = "nixos";
          username = "lxs";
          extraModules = [
            nixos-wsl.nixosModules.wsl
            ./modules/wsl
            ./profiles/lxs-personal.nix
          ];
        };
      };

      darwinConfigurations = {
        Lukes-MacBook-Pro = mkDarwinConfig {
          hostname = "Lukes-MacBook-Pro";
          username = "lxs";
          extraModules = [
            ./modules/darwin/work.nix
            ./profiles/lxs-work.nix
          ];
        };
        josie-personal-macbook = mkDarwinConfig {
          system = "x86_64-darwin";
          hostname = "josie-personal-macbook";
          username = "lxs";
          extraModules = [
            ./profiles/lxs-personal.nix
          ];
        };
      };

      homeConfigurations = {
        lxs = mkHomeConfig {
          system = builtins.currentSystem;
          hostname = null;
          username = "lxs";
          extraModules = [ ];
        };
      };
    };
}
