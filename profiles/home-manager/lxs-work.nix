{
  homeDirectory,
  config,
  pkgs,
  ...
}: {
  programs = {
    git = {
      includes = [
        {
          condition = "gitdir:${config.home.homeDirectory}/Development/Seccl/";
          contents = {
            user = {
              email = "luke.xaviersymington@seccl.tech";
              signingkey = "D580A64AA71C62C3";
            };
            gpg = {
              program = "${pkgs.gnupg}/bin/gpg";
            };
            commit = {
              gpgSign = true;
            };
            remote = {
              origin = {
                fetch = [
                  "+refs/heads/*:refs/remotes/origin/*"
                ];
              };
            };
          };
        }
      ];
    };

    ssh = {
      enable = true;
      matchBlocks = {
        Seccl = {
          hostname = "github.com";
          forwardAgent = true;
          identitiesOnly = true;
          identityFile = "${homeDirectory}/.ssh/seccl_ed25519";
          extraOptions = {
            AddKeysToAgent = "yes";
            UseKeychain = "yes";
          };
        };
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
