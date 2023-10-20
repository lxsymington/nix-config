{ self, inputs, ... }: {
  imports = [
    ../common.nix
    ./core.nix
    ./preferences.nix
  ];
}
