{ inputs, ... }:

{
  imports = [ inputs.core.nixosModules.sops ];

  sops.secrets.your-secret = { };
  sops.secrets.other-secret = { };
}
