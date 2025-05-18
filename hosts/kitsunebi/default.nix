{ inputs, outputs, ... }:

{
  imports = [

    inputs.core.nixosModules.common
    inputs.core.nixosModules.device.laptop
    inputs.core.nixosModules.normalUsers
    inputs.core.nixosModules.openssh
    inputs.core.nixosModules.pipewire

    outputs.nixosModules.common

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


  hardware.openrazer.enable = true;

  programs.gamemode.enable = true;

  networking = {
    hostName = "kitsunebi";
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
        "openrazer"
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
