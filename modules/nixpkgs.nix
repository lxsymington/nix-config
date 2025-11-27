{
  inputs,
  config,
  username,
  pkgs,
  ...
}: {
  nix = {
    gc = {
      automatic = true;
      interval = [
        {
          Hour = 12;
          Minute = 30;
          Weekday = 3;
        }
      ];
      options = "--delete-older-than 7d";
    };

    nixPath =
      builtins.map
      (source: "${source}=/etc/${config.environment.etc.${source}.target}") [
        "home-manager"
        "nixpkgs"
      ];

    optimise = {
      automatic = true;
      interval = [
        {
          Hour = 8;
          Minute = 15;
        }
      ];
    };

    registry = {
      nixpkgs = {
        from = {
          id = "nixpkgs";
          type = "indirect";
        };
        flake = inputs.nixpkgs;
      };
    };

    settings = {
      accept-flake-config = true;
      allowed-users = [username "root" "@admin" "@wheel"];
      experimental-features = ["nix-command" "flakes"];
      system-features = ["benchmark" "big-parallel" "nixos-test" "kvm"];
      trusted-users = [username "root" "@admin" "@wheel"];
    };
  };
}
