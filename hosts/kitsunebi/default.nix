{
  pkgs,
  inputs,
  outputs,
  ...
}:

{
  imports = [

    inputs.core.nixosModules.common
    inputs.core.nixosModules.device.laptop
    inputs.core.nixosModules.normalUsers
    inputs.core.nixosModules.openssh

    outputs.nixosModules.common

    ./boot.nix
    ./hardware.nix
    ./packages.nix
  ];

  #  nixpkgs.config.cudaSupport = true;

  services.flatpak.enable = true;

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = false;
    localNetworkGameTransfers.openFirewall = true;
  };

  #  programs.steam.gamescopeSession.enable = true;
  # programs.gpu-screen-recorder = {
  #  enable = true;
  ##  package = (pkgs.gpu-screen-recorder.override {
  ##    cudaSupport = true;
  ##  });
  #};

  hardware.openrazer.enable = true;

  programs.adb.enable = true;

  programs.gamemode = {
    enable = true;
    #  settings =
  };

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
        "gamemode"
        "adbusers"
      ];
    };
  };

  system.stateVersion = "24.11";
}
