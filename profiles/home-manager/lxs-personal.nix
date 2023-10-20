{ homeDirectory, ... }: {
  programs.ssh = {
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
}
