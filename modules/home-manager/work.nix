{ config, pkgs, ... }:

let
  assume-role = builtins.fetchGit {
    url = "git@github.com:ibisnetworks/assume-role.git";
    ref = "master";
    rev = "b59b398b6c197eb2442a13cf8afe08936501b881";
  };
in
{
  imports = [
    ./fish/work.nix
  ];

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
      AUTO_OPS = "${config.home.homeDirectory}/.seccl/auto-ops";
      AWS_PROFILE = "sandbox";
      AWS_REGION = "eu-west-1";
      AWS_SDK_LOAD_CONFIG = "1";
      CORE_ENV = "sandbox";
      STAGE_ENV = "devlsymington";
      # Required for AUTO_OPS first time setup
      NVM_DIR = "${config.home.homeDirectory}/.nvm";
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
