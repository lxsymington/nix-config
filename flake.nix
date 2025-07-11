{
  description = "System configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nixpkgs-stable.url = "github:NixOS/nixpkgs/nixos-23.11";

    darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-darwin/nix-darwin/master";
    };

    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager";
    };

    nh = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nh";
    };

    nix-index-database = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:Mic92/nix-index-database";
    };

    nixos-wsl = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/NixOS-WSL";
    };

    nur = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/NUR";
    };

    mac-app-util = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:hraban/mac-app-util";
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
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:lxsymington/nix-neovim";
    };

    mergiraf = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "git+https://codeberg.org/mergiraf/mergiraf";
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

    stylix = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:danth/stylix";
    };

    ssh-agent-fish = {
      url = "github:danhper/fish-ssh-agent";
      flake = false;
    };

    vscode-server = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/nixos-vscode-server";
    };

    zed = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:zed-industries/zed";
    };
  };

  outputs = {
    darwin,
    home-manager,
    mac-app-util,
    nh,
    nix-index-database,
    nix-vscode-extensions,
    nixos-wsl,
    nixpkgs,
    nixpkgs-stable,
    nur,
    self,
    stylix,
    vscode-server,
    lxs-nvim,
    zed,
    ...
  } @ inputs: let
    inherit (nixpkgs.lib) nixosSystem;
    inherit (darwin.lib) darwinSystem;
    inherit (home-manager.lib) homeManagerConfiguration;
    inherit (builtins) elem;

    isDarwin = system: (elem system nixpkgs.lib.platforms.darwin);
    homePrefix = system:
      if isDarwin system
      then "/Users"
      else "/home";
    homeDirectory = {
      system,
      username,
    }: "${homePrefix system}/${username}";

    nixpkgsWithOverlays = system: (import nixpkgs rec {
      inherit nixpkgs nixpkgs-stable system;
      config = {
        allowUnsupportedSystem = true;
        allowUnfree = true;
        allowBroken = false;
      };
      overlays = [
        nur.overlays.default
        (_final: prev: {
          # this allows us to reference pkgs.stable
          stable = import nixpkgs-stable {
            inherit (prev) system;
            inherit config;
          };
        })
        nh.overlays.default
        nix-vscode-extensions.overlays.default
        lxs-nvim.overlays.${system}.default
        zed.overlays.default
      ];
    });

    argDefaults = {
      hostname,
      system,
      username,
    }: {
      inherit self hostname inputs nix-index-database username;
      homeDirectory = homeDirectory {
        inherit system username;
      };
      channels = {
        inherit nixpkgs nixpkgs-stable;
      };
    };

    mkNixosConfiguration = {
      system ? "x86_64-linux",
      hostname,
      username,
      args ? {},
      extraModules ? [],
    }: let
      specialArgs = argDefaults {inherit hostname system username;} // args;
    in
      nixosSystem {
        inherit system specialArgs;
        pkgs = nixpkgsWithOverlays system;
        modules =
          [
            home-manager.nixosModules.home-manager
            stylix.nixosModules.stylix
            vscode-server.nixosModules.default
            ./modules/nixos
          ]
          ++ extraModules;
      };

    mkDarwinConfig = {
      system ? "aarch64-darwin",
      hostname,
      username,
      args ? {},
      extraModules ? [],
    }: let
      specialArgs = argDefaults {inherit hostname system username;} // args;
    in
      darwinSystem {
        inherit system specialArgs;
        pkgs = nixpkgsWithOverlays system;
        modules =
          [
            mac-app-util.darwinModules.default
            home-manager.darwinModules.home-manager
            ({...}: {
              # Or to enable it for a single user only:
              home-manager.users.${username}.imports = [
                #...
                mac-app-util.homeManagerModules.default
              ];
            })
            stylix.darwinModules.stylix
            ./modules/darwin
          ]
          ++ extraModules;
      };

    mkHomeConfig = {
      system ? "x86_64-linux",
      hostname,
      username,
      args ? {},
      extraModules ? [],
    }: let
      specialArgs = argDefaults {inherit hostname system username;} // args;
    in
      homeManagerConfiguration {
        inherit specialArgs;
        pkgs = nixpkgsWithOverlays {inherit system;};
        modules =
          [
            stylix.homeManagerModules.stylix
            ./modules/home-manager
            {
              home = {
                inherit username homeDirectory;
                sessionVariables = {
                  NIX_PATH = "nixpkgs=${nixpkgs}:stable=${nixpkgs-stable}\${NIX_PATH:+:}$NIX_PATH";
                };
              };
            }
          ]
          ++ extraModules;
      };
  in {
    formatter = {
      x86_64-linux = nixpkgs.legacyPackages.x86_64-linux.alejandra;
      aarch64-darwin = nixpkgs.legacyPackages.aarch64-darwin.alejandra;
      x86_64-darwin = nixpkgs.legacyPackages.x86_64-darwin.alejandra;
    };

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
      josie-personal-imac = mkDarwinConfig {
        system = "x86_64-darwin";
        hostname = "josie-personal-imac";
        username = "lukesymington";
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
        extraModules = [];
      };
    };
  };
}
