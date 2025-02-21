{ inputs, outputs, ... }:

{
  imports = [
    inputs.core.nixosModules.common
    inputs.core.nixosModules.nginx
    inputs.core.nixosModules.normalUsers
    inputs.core.nixosModules.openssh

    outputs.nixosModules.common

    ./boot.nix
    ./hardware.nix # will be generated during installation
    ./packages.nix
  ];

  networking.hostName = "HOSTNAME";

  services = {
    nginx.enable = true;
    openssh.enable = true;
  };

  normalUsers = {
    susagi = {
      name = "susagi";
      extraGroups = [
        "wheel"
      ];
      sshKeyFiles = [ ../../users/susagi/pubkeys/vde_rsa.pub];
    };
  };
  system.stateVersion = "24.11";
}
