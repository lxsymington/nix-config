{ config, pkgs, ... }:

{
  home = {
    sessionPath = [
      "${config.home.homeDirectory}/.asdf/shims"
    ];
  };

  programs = {
    fish = {
      interactiveShellInit = ''
        if test -e ${config.home.homeDirectory}/.asdf/asdf.fish -a -x ${config.home.homeDirectory}/.asdf/asdf.fish
          replay source ${config.home.homeDirectory}/.asdf/asdf.fish
        end
      '';
      functions = {
        # Required for first time AUTO_OPS setup
        nvm = {
          description = "nvm";
          body = ''
            replay source ${config.home.homeDirectory}/.nvm/nvm.sh --no-use ';' nvm $argv
          '';
        };
        nvm_find_nvmrc = {
          description = "find nvmrc";
          body = ''
            replay source ${config.home.homeDirectory}/.nvm/nvm.sh --no-use ';' nvm_find_nvmrc
          '';
        };
        load_nvm = {
          description = "load nvmrc";
          onVariable = "PWD";
          body = ''
            set -l default_node_version (nvm version default)
            set -l node_version (nvm version)
            set -l nvmrc_path (nvm_find_nvmrc)
            if test -n "$nvmrc_path"
              set -l nvmrc_node_version (nvm version (cat $nvmrc_path))
              if test "$nvmrc_node_version" = "N/A"
                nvm install (cat $nvmrc_path)
              else if test "$nvmrc_node_version" != "$node_version"
                nvm use $nvmrc_node_version
              end
            else if test "$node_version" != "$default_node_version"
              echo "Reverting to default Node version"
              nvm use default
            end
          '';
        };
      };
    };
  };
  
  xdg = {
    configFile = {
      "fish/completions/asdf.fish" = {
        source = "${pkgs.asdf-vm}/share/fish/vendor_completions.d/asdf.fish";
      };
    };
  };
}
