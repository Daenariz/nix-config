{ inputs, outputs, ... }:

{
  imports = [
    inputs.core.nixosModules.common
    inputs.core.nixosModules.normalUsers
    inputs.core.nixosModules.openssh
    inputs.core.nixosModules.pipewire

    outputs.nixosModules.common

    ./boot.nix
    ./hardware.nix # will be generated during installation
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
        "audio"
        "floppy"
        "input"
        "lp"
        "networkmanager"
        "video"
        "wheel"
      ];
      # sshKeyFiles = [ ../../users/susagi/pubkeys/YOUR_PUBKEY.pub ]; # FIXME: Set your pubkey
    };
  };

  system.stateVersion = "24.11";
}
