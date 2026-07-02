{
  config,
  inputs,
  ...
}:
{
  imports = [ inputs.synix.nixosModules.sops ];

  # sops.secrets."mailserver/accounts/susagi" = { };
  sops.secrets."ntfy_topic" = { };
  sops.secrets.riichi_club_key = { };
  sops.secrets."tailscale/auth-key" = { };
  sops.secrets."forgejo_runner_token" = { };
  sops.templates."forgejo_runner_token".content = "TOKEN=${config.sops.placeholder."forgejo_runner_token"}";
}
