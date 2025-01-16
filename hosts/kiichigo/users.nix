{ outputs, ... }:

{
  imports = [ outputs.nixosModules.normalUsers ];

  normalUsers = {
    susagi = {
      name = "susagi";
      extraGroups = [ "wheel" ];
      sshKeyFiles = [
        ../../users/susagi/pubkeys/vde_rsa.pub
        ../../users/susagi/pubkeys/id_rsa.pub
        ../../users/susagi/pubkeys/tab.pub
      ];
    };
  };
}
