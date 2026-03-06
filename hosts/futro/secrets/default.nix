{ inputs, ... }:

{
  imports = [ inputs.synix.nixosModules.sops ];

  sops.secrets."mailserver/accounts/susagi" = { };
}
