{
  inputs,
  outputs,
  pkgs,
  ...
}:

{
  imports = [

    inputs.core.nixosModules.common
    inputs.core.nixosModules.device.laptop
    inputs.core.nixosModules.normalUsers
    inputs.core.nixosModules.hyprland
    inputs.core.nixosModules.openssh

    inputs.core.nixosModules.virtualization
    #inputs.ha-test.nixosModules.home-assistant-oci

    outputs.nixosModules.common

    ./boot.nix
    ./hardware.nix
    ./packages.nix
  ];

  services.xserver.xkb.layout = "de";

  services.displayManager.sddm = {
    enable = true;
    wayland.enable = true;
    #    settings = {
    #};
  };

  networking = {
    hostName = "naboshi";
    firewall.allowedUDPPorts = [ 24727 ];
    #    firewall.allowedTCPPorts = [ 8123 ];
  };

  services = {
    udev.packages = with pkgs; [
      platformio-core.udev
    ];
    openssh.enable = true;
    pipewire.enable = true;
    flatpak.enable = true;
  };

  programs.hyprland.enable = true;

  normalUsers = {
    susagi = {
      name = "susagi";
      extraGroups = [
        "input"
        "audio"
        "floppy"
        "lp"
        "networkmanager"
        "video"
        "wheel"
        "dialout"
        "libvirtd"
      ];
    };
  };

  system.stateVersion = "24.11";
}
