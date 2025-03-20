{ inputs, outputs, ... }:

{
  imports = [

    inputs.core.nixosModules.common
    inputs.core.nixosModules.device.laptop
    inputs.core.nixosModules.normalUsers
    inputs.core.nixosModules.hyprland
    inputs.core.nixosModules.openssh
    inputs.core.nixosModules.pipewire
    inputs.ha-test.nixosModules.home-assistant-oci

    outputs.nixosModules.common

    ./boot.nix
    ./hardware.nix
    ./packages.nix
  ];

  networking = {
    hostName = "naboshi";
    firewall.allowedUDPPorts = [ 24727 ];
    firewall.allowedTCPPorts = [ 8123 ];
  };

  services = {
    openssh.enable = true;
    pipewire.enable = true;
  };

  services.homeAssistantModule = {
    enable = true;
  };

  programs.hyprland.enable = true;

  normalUsers = {
    susagi = {
      name = "susagi";
      extraGroups = [
        "input"
        #"dm"
        "audio"
        "floppy"
        #"log"
        "lp"
        "networkmanager"
        #"optical"
        #"rfkill"
        #"scanner"
        #"storage"
        #"sys"
        "video"
        "wheel"
      ];
    };
  };

  system.stateVersion = "24.11";
}
