{
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
      generateCompletions = true;
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
