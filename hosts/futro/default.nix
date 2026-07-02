{
  inputs,
  outputs,
  config,
  ...
}:
{
  imports = [
    inputs.synix.nixosModules.common
    inputs.synix.nixosModules.normalUsers
    inputs.synix.nixosModules.openssh

    ./secrets
    outputs.nixosModules.common

    ./boot.nix
    ./hardware.nix # will be generated during installation
    ./packages.nix
    ./services
  ];

  networking = {
    firewall = {
      enable = true;
      trustedInterfaces = [ "tailscale0" ];
      checkReversePath = "loose";
    };
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
        ../../users/susagi/pubkeys/handy.pub
      ];
    };
  };
  system.stateVersion = "24.11";
}
