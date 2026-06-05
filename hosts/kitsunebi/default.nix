{
  pkgs,
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.synix.nixosModules.common
    inputs.synix.nixosModules.bluetooth
    inputs.synix.nixosModules.device.desktop
    inputs.synix.nixosModules.normalUsers
    inputs.synix.nixosModules.openssh

    ./boot.nix
    ./hardware.nix
    ./packages.nix
    ./secrets
    ./ollama.nix
  ];

  services.tailscale.enable = true;

  programs.dconf.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = false;
    localNetworkGameTransfers.openFirewall = true;
  };

  hardware.openrazer.enable = true;

  programs.adb.enable = true;

  programs.gamemode = {
    enable = true;
  };

  networking = {
    hostName = "kitsunebi";
    interfaces.eno1.wakeOnLan.enable = true;
  };

  services = {
    openssh.enable = true;
  };

  normalUsers = {
    neo = {
      extraGroups = [
        "openrazer"
        "input"
        "audio"
        "floppy"
        "lp"
        "networkmanager"
        "video"
        "wheel"
        "gamemode"
        "adbusers"
      ];
      sshKeyFiles = [
        ../../users/susagi/pubkeys/vde_rsa.pub
        ../../users/susagi/pubkeys/futro_rsa.pub
        ../../users/susagi/pubkeys/kyojin_rsa.pub
        ../../users/susagi/pubkeys/handy.pub
      ];
    };
  };

  system.stateVersion = "24.11";
}
