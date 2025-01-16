{ inputs, outputs, ... }:

{
  imports = [

    inputs.core.nixosModules.common
    inputs.core.nixosModules.device.laptop
    inputs.core.nixosModules.normalUsers
    inputs.core.nixosModules.openssh
    inputs.core.nixosModules.pipewire

    #    outputs.nixosModules.common

    ./boot.nix
    ./hardware.nix
    ./packages.nix
  ];

  networking.hostName = "naboshi";

  services = {
    openssh.enable = true;
    pipewire.enable = true;
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
