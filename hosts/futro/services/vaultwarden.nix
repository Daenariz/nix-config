{ outputs, config, ... }:
{
  imports = [
    outputs.nixosModules.vaultwarden
  ];

  services.vaultwarden = {
    enable = true;
    # Vaultwarden needs to know the public URL is HTTPS
    config.DOMAIN = "https://vault.${config.networking.domain}";
    reverseProxy = {
      enable = true;
      subdomain = "vault";
      forceSSL = false;
    };
  };
}
