{ inputs, ... }:

{
  imports = [ inputs.synix.nixosModules.sops ];

  sops.secrets."mailserver/accounts/susagi" = { };
  sops.secrets."ntfy_topic" = { };
}
