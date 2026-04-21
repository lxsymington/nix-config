{
  description = "System configurations";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
    };

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

    opencode = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:anomalyco/opencode";
    };

    openspec = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:Fission-AI/OpenSpec";
    };
  };

  outputs = inputs @ {
    darwin,
    flake-parts,
    home-manager,
    lxs-nvim,
    nh,
    nix-index-database,
    nixos-wsl,
    nixpkgs,
    nur,
    self,
    stylix,
    ...
  }: let
    inherit (nixpkgs.lib) nixosSystem;
    inherit (darwin.lib) darwinSystem;
    inherit (home-manager.lib) homeManagerConfiguration;
    inherit (builtins) elem;

    isDarwin = system: (elem system nixpkgs.lib.platforms.darwin);
    homePrefix = system:
      if isDarwin system
      then "/Users"
      else "/home";
    buildHomeDirectoryPath = {
      system,
      username,
    }: "${homePrefix system}/${username}";

    nixpkgsWithOverlays = system: (import nixpkgs {
      inherit nixpkgs system;
      config = {
        allowUnsupportedSystem = true;
        allowUnfree = true;
        allowBroken = false;
      };
      overlays = [
        nur.overlays.default
        nh.overlays.default
        lxs-nvim.overlays.default
      ];
    });

    argDefaults = {
      hostname,
      system,
      username,
    }: {
      inherit self hostname inputs nix-index-database username;
      homeDirectory = buildHomeDirectoryPath {
        inherit system username;
      };
      channels = {
        inherit nixpkgs;
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
      darwinSystem rec {
        inherit system specialArgs;
        pkgs = nixpkgsWithOverlays system;
        modules =
          [
            home-manager.darwinModules.home-manager
            stylix.darwinModules.stylix
            ./modules/darwin
            ./modules/nixpkgs.nix
          ]
          ++ extraModules;
      };

    mkHomeConfig = {
      system ? "x86_64-darwin",
      hostname,
      username,
      args ? {},
      extraModules ? [],
    }: let
      specialArgs = argDefaults {inherit hostname system username;} // args;
      homeDirectory = buildHomeDirectoryPath {
        inherit system username;
      };
    in
      homeManagerConfiguration {
        extraSpecialArgs = specialArgs;
        pkgs = nixpkgsWithOverlays system;
        modules =
          [
            stylix.homeModules.stylix
            ./modules/home-manager
            {
              home = {
                inherit username homeDirectory;
                sessionVariables = {
                  NIX_PATH = "nixpkgs=${nixpkgs}\${NIX_PATH:+:}$NIX_PATH";
                };
              };
            }
          ]
          ++ extraModules;
      };
  in
    flake-parts.lib.mkFlake {inherit inputs;} (top @ {
      config,
      withSystem,
      moduleWithSystem,
      ...
    }: {
      imports = [
        inputs.home-manager.flakeModules.home-manager
      ];

      flake = {
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
          FGK6CWXWQN = mkDarwinConfig {
            hostname = "FGK6CWXWQN";
            username = "lxs";
            extraModules = [
              ./modules/darwin/work.nix
              ./profiles/lxs-work.nix
            ];
          };
        };

        homeConfigurations = {
          lukesymington = mkHomeConfig {
            system = "x86_64-darwin";
            hostname = "josie-personal-imac";
            username = "lukesymington";
            extraModules = [
              ./profiles/home-manager/lxs-personal.nix
            ];
          };
        };
      };

      systems = [
        "x86_64-linux"
        "aarch64-darwin"
        "x86_64-darwin"
      ];

      perSystem = {
        config,
        pkgs,
        ...
      }: {
        formatter = pkgs.alejandra;
      };
    });
}
