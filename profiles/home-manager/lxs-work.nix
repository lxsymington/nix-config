{ config, ... }: {
  programs.ssh = {
    enable = true;
    matchBlocks = {
      Seccl = {
        hostname = "github.com";
        forwardAgent = true;
        identitiesOnly = true;
        identityFile = "${config.home.homeDirectory}/.ssh/seccl_ed25519";
        extraOptions = {
          AddKeysToAgent = "yes";
          UseKeychain = "yes";
        }; 
      };
      Personal = {
        hostname = "github.com";
        forwardAgent = true;
        identitiesOnly = true;
        identityFile = "${config.home.homeDirectory}/.ssh/personal_ed25519";
        extraOptions = {
          AddKeysToAgent = "yes";
          UseKeychain = "yes";
        }; 
      };
    };
  };
}
