{ inputs, outputs, ... }:

{
  imports = [
    #./wyoming.nix
    #  ./homeassistant.nix
    ./boot.nix
    ./hardware.nix
    ./networking.nix
    ./packages.nix
    #./services.nix
    ./users.nix
    inputs.core.nixosModules.common
    inputs.core.nixosModules.sops
    inputs.core.nixosModules.openssh

    outputs.nixosModules.common

  ];

  programs.ssh.startAgent = true;

  services.openssh = {
    enable = true;
    #    ports = [ 3407 ];
  };
  system.stateVersion = "26.06";
}
