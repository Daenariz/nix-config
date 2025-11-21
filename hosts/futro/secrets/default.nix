{ inputs, ... }:

{
  imports = [ inputs.core.nixosModules.sops ];

  sops.secrets."mailserver/accounts/susagi" = { };
  sops.secrets.test-secret = {};
}
