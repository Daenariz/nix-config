{
  inputs,
  lib,
  ...
}: {
  imports = [
    inputs.synix.nixosModules.common
    inputs.synix.nixosModules.device.laptop
    inputs.synix.nixosModules.normalUsers
    inputs.synix.nixosModules.openssh
    inputs.synix.nixosModules.pipewire

    ./boot.nix
    ./hardware.nix
    ./packages.nix
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = false;
    localNetworkGameTransfers.openFirewall = true;
  };

  programs.gamemode.enable = true;

  networking = {
    hostName = "akiyama";
  };

  services = {
    openssh.enable = true;
    pipewire.enable = true;
  };

  programs.hyprland.enable = true;

  normalUsers = {
    neo = {
      name = "neo";
      extraGroups = [
        "input"
        "audio"
        "floppy"
        "lp"
        "networkmanager"
        "video"
        "wheel"
      ];
    };
  };

  system.stateVersion = "24.11";
}
