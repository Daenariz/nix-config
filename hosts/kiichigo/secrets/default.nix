{ inputs, ... }:
{
  imports = [ inputs.synix-stable.nixosModules.sops ];

  sops.secrets."tailscale/auth-key" = { };
}
