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

  networking = {
    hostName = "futro";
    interfaces.enp1s0.wakeOnLan = {
      enable = true;
      policy = [
        "magic"
      ];
    };
  };

  services = {
    #    nginx.enable = true;
    openssh = {
      enable = true;
      ports = [
        22
      ];
    };
  };

  normalUsers = {
    susagi = {
      name = "susagi";
      extraGroups = [
        "wheel"
      ];
      sshKeyFiles = [ ../../users/susagi/pubkeys/vde_rsa.pub ];
    };
  };
  system.stateVersion = "24.11";
}
