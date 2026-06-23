{ inputs, ... }:
{
  imports = [ inputs.synix.nixosModules.sops ];

  sops.secrets."tailscale/auth-key" = { };
}
