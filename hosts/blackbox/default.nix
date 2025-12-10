{ pkgs, inputs, lib, config, outputs, ... }:

{
  imports = [
    inputs.nixos-raspberrypi.nixosModules.raspberry-pi-5.base
    inputs.nixos-raspberrypi.nixosModules.raspberry-pi-5.bluetooth
        ./boot.nix
    ./hardware.nix
    #  ./users.nix
    #    ./packages.nix
    ./networking.nix
  ];

  ##programs.ssh.startAgent = true;
users.users.susagi = {
    initialPassword = "changeme";
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  services.openssh = {
    enable = true;
        ports = [ 22 ];
  };
  nix.settings = {
    experimental-features = [ "nix-command" "flakes" ];
    extra-substituters = [
      "https://nixos-raspberrypi.cachix.org"
    ];
    extra-trusted-public-keys = [
      "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
    ];
  };
  system.stateVersion = "25.05";
}
