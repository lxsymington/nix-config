{homeDirectory, ...}: {
  programs = {
    git = {
      signing = {
        format = "openpgp";
        key = "270A8C4789572627";
        signByDefault = true;
      };
    };

    ssh = {
      enable = true;
      matchBlocks = {
        Personal = {
          hostname = "github.com";
          forwardAgent = true;
          identitiesOnly = true;
          identityFile = "${homeDirectory}/.ssh/personal_ed25519";
          extraOptions = {
            AddKeysToAgent = "yes";
            UseKeychain = "yes";
          };
        };
      };
    };
  };
}
