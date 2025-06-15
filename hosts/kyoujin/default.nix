{ inputs, outputs, ... }:

{
  imports = [
   inputs.core.nixosModules.normalUsers
    ./wyoming.nix
    #  ./homeassistant.nix
    ./boot.nix
    ./hardware.nix
    ./networking.nix
    ./packages.nix
#    ./services.nix
    ./ollama.nix
    inputs.core.nixosModules.common
    inputs.core.nixosModules.sops
    inputs.core.nixosModules.nvidia

    outputs.nixosModules.common

  ];

  normalUsers = {
    susagi = {
      extraGroups = [ "wheel" ];
      sshKeyFiles = [
        ../../users/susagi/pubkeys/vde_rsa.pub
        ../../users/susagi/pubkeys/id_rsa.pub
        ../../users/susagi/pubkeys/tab.pub
        ../../users/susagi/pubkeys/w10_rsa.pub
        ../../users/neo/kitsunebi_rsa.pub
      ];
    };
  };

  programs.ssh.startAgent = true;

  services.openssh = {
    enable = true;
    ports = [ 3407 ];
  };
  system.stateVersion = "24.11";


}
