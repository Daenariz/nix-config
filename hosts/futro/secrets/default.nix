{ inputs, ... }:

{
  imports = [ inputs.core.nixosModules.sops ];

  #sops.secrets.other-secret = { };
}
