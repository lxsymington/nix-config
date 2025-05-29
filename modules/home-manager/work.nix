{
  config,
  pkgs,
  ...
}: let
  assume-role = builtins.fetchGit {
    url = "git@github.com:ibisnetworks/assume-role.git";
    rev = "b59b398b6c197eb2442a13cf8afe08936501b881";
  };
in {
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
      MONGO_AWS_PROFILE = "secclenv-sandbox";
      STAGE_ENV = "devlsymington";
    };
  };

  programs = {
    go = {
      packages = {
        "github.com/ibisnetworks/assume-role" = assume-role;
      };
    };
  };
}
