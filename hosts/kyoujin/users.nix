{ inputs, outputs, ... }:

{
  imports = [ inputs.core.nixosModules.normalUsers ];

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
}
