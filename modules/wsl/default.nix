{
  pkgs,
  username,
  ...
}: {
  # For vscode-server see this issue: https://github.com/nix-community/NixOS-WSL/issues/294#issuecomment-1793362619

  environment.systemPackages = [
    (import ./win32yank.nix {inherit pkgs;})
    pkgs.wget
    pkgs.wslu
  ];

  programs = {
    nix-ld = {
      enable = true;
    };
  };

  services = {
    vscode-server = {
      enable = true;
    };
  };

  virtualisation.docker = {
    enable = true;
    enableOnBoot = true;
    autoPrune.enable = true;
  };

  wsl = {
    defaultUser = username;
    docker-desktop.enable = false;
    enable = true;

    extraBin = with pkgs; [
      {src = "${coreutils}/bin/uname";}
      {src = "${coreutils}/bin/dirname";}
      {src = "${coreutils}/bin/readlink";}
    ];

    startMenuLaunchers = true;

    wslConf = {
      automount.root = "/mnt";
      interop.appendWindowsPath = false;
      network.generateHosts = false;
    };
  };
}
