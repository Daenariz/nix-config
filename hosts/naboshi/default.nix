{ outputs, ... }:

{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./packages.nix

    outputs.nixosModules.common
    outputs.nixosModules.device.laptop
    outputs.nixosModules.openssh
    outputs.nixosModules.pipewire
    outputs.nixosModules.normalUsers
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
        "dm"
        "audio"
        "floppy"
        "log"
        "lp"
        "networkmanager"
        "optical"
        "rfkill"
        "scanner"
        "storage"
        "sys"
        "video"
        "wheel"
      ];
    };
  };

  system.stateVersion = "24.11";
}
