{ inputs, outputs, ... }:

{
  imports = [
    inputs.core.nixosModules.common
    inputs.core.nixosModules.nginx
    inputs.core.nixosModules.normalUsers
    inputs.core.nixosModules.openssh
    inputs.core.nixosModules.open-webui

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

services.open-webui = {
  enable = true;
  openFirewall = true;
  host = "0.0.0.0";
#    environment.ENABLE_SIGNUP = "True"; # Delete this in step 5
};

  services = {
    #    nginx.enable = true;
    openssh = {
      enable = true;
      ports = [
        30715 
      ];
    };
  };

  programs.ssh.startAgent = true;

  normalUsers = {
    susagi = {
      extraGroups = [
        "wheel"
      ];
      sshKeyFiles = [ 
        ../../users/susagi/pubkeys/vde_rsa.pub
	../../users/susagi/pubkeys/futro_rsa.pub
    ../../users/susagi/pubkeys/kyojin_rsa.pub
      ];
    };
  };
  system.stateVersion = "24.11";
}
