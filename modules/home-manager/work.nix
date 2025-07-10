{
  config,
  pkgs,
  ...
}: {
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
      AWS_PROFILE = "secclenv-sandbox";
      AWS_REGION = "eu-west-1";
      AWS_SDK_LOAD_CONFIG = "1";
      CORE_ENV = "sandbox";
      MONGO_AWS_PROFILE = "secclenv-sandbox";
      STAGE_ENV = "devlsymington";
    };
  };
}
