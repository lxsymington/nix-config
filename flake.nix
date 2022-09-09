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
    lxs-neovim = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:lxsymington/lxs-neovim";
    };
    lsp-nil = {
      url = "github:oxalica/nil";
    };
  };

  outputs = { self, nixpkgs, darwin, home-manager, lxs-neovim, lsp-nil, ... }@inputs:
    let
      inherit (darwin.lib) darwinSystem;
      inherit (home-manager.lib) homeManagerConfiguration;
      inherit (builtins) listToAttrs map elem;

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
        , extraModules ? [ ]
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
                lxs-neovim = lxs-neovim.defaultPackage.${final.system};
                rnix-lsp = lsp-nil.packages.${final.system}.default;
              })
            ];
          };
          modules = baseModules ++ extraModules;
          specialArgs = { inherit self inputs nixpkgs stable; };
        };

      # generate a home-manager configuration usable on any unix system
      # with overlays and any extraModules applied
      # mkHomeConfig = {
      #   username,
      #   system ? "x86_64-linux",
      #   nixpkgs ? inputs.nixpkgs,
      #   stable ? inputs.stable,
      #   baseModules ? [
      #     ./modules/home-manager
      #     {
      #       home = {
      #         inherit username;
      #         homeDirectory = "${homePrefix system}/${username}";
      #         sessionVariables = {
      #           NIX_PATH =
      #             "nixpkgs=${nixpkgs}:stable=${stable}\${NIX_PATH:+:}$NIX_PATH";
      #         };
      #       };
      #     }
      #   ],
      #   extraModules ? [ ]
      # }: homeManagerConfiguration rec {
      #   pkgs = import nixpkgs {
      #     inherit system;
      #     overlays = [
      #       (final: prev: {
      #         lxs-neovim = lxs-neovim.defaultPackage.${final.system};
      #         rnix-lsp = lsp-nil.defaultPackagae.${final.system};
      #       })
      #     ];
      #   };
      #   extraSpecialArgs = { inherit inputs nixpkgs stable; };
      #   modules = baseModules ++ extraModules ++ [ ./modules/overlays.nix ];
      # };
    in
    {
      darwinConfigurations = {
        seccl-macbook = mkDarwinConfig {
          system = "x86_64-darwin";
          extraModules = [ ./profiles/lukexaviersymington-work.nix ];
        };
        lxs-seccl-macbook = mkDarwinConfig {
          extraModules = [ ./profiles/lxs-work.nix ];
        };
      };

      # homeConfigurations = {
      #   seccl2020 = mkHomeConfig {
      #     username = "lukexaviersymington";
      #     extraModules = [];
      #   };
      #   seccl2022 = mkHomeConfig {
      #     username = "lxs";
      #     extraModules = [];
      #   };
      # };
    };
}
