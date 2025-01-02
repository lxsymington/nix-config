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

    done = {
      url = "github:franciscolourenco/done";
      flake = false;
    };

    fish-nix-env = {
      url = "github:lilyball/nix-env.fish";
      flake = false;
    };

    lxs-nvim = {
      url = "github:lxsymington/nix-neovim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    mergiraf = {
      url = "git+https://codeberg.org/mergiraf/mergiraf";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nix-vscode-extensions";
    };

    pisces = {
      url = "github:laughedelic/pisces";
      flake = false;
    };

    replay = {
      url = "github:jorgebucaran/replay.fish";
      flake = false;
    };

    ssh-agent-fish = {
      url = "github:danhper/fish-ssh-agent";
      flake = false;
    };

    vscode-server = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nixos-vscode-server";
    };
  };

  outputs =
    { darwin
    , home-manager
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
