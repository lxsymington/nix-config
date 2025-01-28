{ config
, pkgs
, ...
}:
let
  assume-role = builtins.fetchGit {
    url = "git@github.com:ibisnetworks/assume-role.git";
    rev = "b59b398b6c197eb2442a13cf8afe08936501b881";
  };
  connect-to-mongo = builtins.fetchGit {
    url = "git@Seccl:SecclTech/code-squad-scripts";
    rev = "82d7b742a5b7de8a63106dc0f479bd93aba0919e";
  };

  connect-to-mongo-fish = builtins.readFile "${connect-to-mongo}/mongo-compass-aws-auth/auth.fish";
in
{
  home = {
    packages = with pkgs; [
      auth0-cli
      awscli2
      # TODO: reinstate this once it's fixed
      # aws-sam-cli
      terraform
    ];

    sessionPath = [
      "${config.home.homeDirectory}/.seccl/bin"
    ];

    sessionVariables = {
      AWS_PROFILE = "sandbox";
      AWS_REGION = "eu-west-1";
      AWS_SDK_LOAD_CONFIG = "1";
      CORE_ENV = "sandbox";
      STAGE_ENV = "devlsymington";
    };
  };

  programs = {
    fish = {
      interactiveShellInit = connect-to-mongo-fish;
    };

    go = {
      packages = {
        "github.com/ibisnetworks/assume-role" = assume-role;
      };
    };
  };
}
