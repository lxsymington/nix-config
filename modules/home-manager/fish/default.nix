{
  pkgs,
  homeDirectory,
  inputs,
  ...
}: {
  programs = {
    fish = {
      enable = true;
      interactiveShellInit = ''
        fish_vi_key_bindings

        if test -e ${homeDirectory}/.seccl/env.sh -a -x ${homeDirectory}/.seccl/env.sh
          replay source ${homeDirectory}/.seccl/env.sh
        end
      '';
      functions = {
        update_nix_index = {
          description = "Update the nix-index for `comma`";
          # Currently there is no index available for `aarch64-darwin`
          # onEvent = "fish_prompt";
          body = ''
            set -l filename "index-${pkgs.system}"
            mkdir -p ${homeDirectory}/.cache/nix-index
            pushd ${homeDirectory}/.cache/nix-index
            # -N will only download a new version if there is an update.
            wget -q -N https://github.com/Mic92/nix-index-database/releases/latest/download/$filename
            ln -f $filename files
            popd
          '';
        };
      };
      plugins = [
        {
          name = "nix-env.fish";
          src = inputs.fish-nix-env.outPath;
        }
        {
          name = "done";
          src = inputs.done.outPath;
        }
        {
          name = "fish-ssh-agent";
          src = inputs.ssh-agent-fish.outPath;
        }
        {
          name = "pisces";
          src = inputs.pisces.outPath;
        }
        {
          name = "replay";
          src = inputs.replay.outPath;
        }
      ];
    };
  };
}
