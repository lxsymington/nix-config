{
  inputs,
  config,
  username,
  pkgs,
  ...
}: {
  nix = {
    extraOptions = ''
      keep-outputs = true
      keep-derivations = true
    '';

    gc = {
      automatic = true;
      options = "--delete-older-than 7d";
    };

    nixPath =
      builtins.map
      (source: "${source}=/etc/${config.environment.etc.${source}.target}") [
        "home-manager"
        "nixpkgs"
        "stable"
      ];

    optimise = {
      automatic = true;
    };

    registry = {
      nixpkgs = {
        from = {
          id = "nixpkgs";
          type = "indirect";
        };
        flake = inputs.nixpkgs;
      };

      stable = {
        from = {
          id = "stable";
          type = "indirect";
        };
        flake = inputs.nixpkgs-stable;
      };
    };

    settings = {
      accept-flake-config = true;
      allowed-users = ["${username}" "root" "@admin" "@wheel"];
      experimental-features = ["nix-command" "flakes"];
      max-jobs = 8;
      system-features = ["benchmark" "big-parallel" "nixos-test" "kvm"];
      trusted-users = ["${username}" "root" "@admin" "@wheel"];
    };
  };
}
