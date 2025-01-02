{ self, inputs, system, ... }: {
  imports = [
    ../common.nix
    ./core.nix
    ./preferences.nix
  ];
}
