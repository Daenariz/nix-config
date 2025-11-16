{
  inputs,
  outputs,
  config,
  ...
}:

{
  imports = [
    inputs.core.nixosModules.common
    inputs.core.nixosModules.normalUsers
    inputs.core.nixosModules.openssh

    ./secrets
    outputs.nixosModules.common

    ./boot.nix
    ./hardware.nix # will be generated during installation
    ./packages.nix
    ./services.nix
  ];

  networking = {
    domain = "negitorodon.de";
    hostName = "futro";
    interfaces.enp1s0.wakeOnLan = {
      enable = true;
      policy = [
        "magic"
      ];
    };
  };

  services.openssh.enable = true;
  services.openssh.ports = [ 30715 ];

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
