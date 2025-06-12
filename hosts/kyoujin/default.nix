{ inputs, outputs, ... }:

{
  imports = [
    ./wyoming.nix
    #  ./homeassistant.nix
    ./boot.nix
    ./hardware.nix
    ./networking.nix
    ./packages.nix
    ./services.nix
    ./users.nix
    inputs.core.nixosModules.common
    inputs.core.nixosModules.sops

    outputs.nixosModules.common

  ];

  programs.ssh.startAgent = true;

  system.stateVersion = "24.11";
}
