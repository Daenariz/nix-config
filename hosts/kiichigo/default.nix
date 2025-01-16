{ outputs, ... }:

{
  imports = [
    ./boot.nix
    ./hardware.nix
    ./networking.nix
    ./packages.nix
    ./services.nix
    ./users.nix

    outputs.nixosModules.common
    outputs.nixosModules.sops
  ];

  programs.ssh.startAgent = true;

  system.stateVersion = "24.11";
}
