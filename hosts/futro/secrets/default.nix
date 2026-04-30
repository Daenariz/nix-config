{ inputs, ... }:

{
  imports = [ inputs.synix.nixosModules.sops ];

  sops.secrets."mailserver/accounts/susagi" = { };
  sops.secrets."ntfy_topic" = { };
  sops.secrets.riichi_club_key = { };
}
