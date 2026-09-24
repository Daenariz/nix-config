{ inputs, ... }:
{
  imports = [ inputs.synix.nixosModules.sops ];

  sops.secrets."tailscale/personal-auth-key" = { };
  sops.secrets."tailscale/work-auth-key" = { };
}
