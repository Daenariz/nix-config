{inputs, config,...}:
{
  imports = [
    inputs.riichi-club.nixosModules.riichi-club
  ];

  services.riichi_club = {
    enable = true;
    nginx.subdomain = "riichi";
    secretKey = config.sops.secrets.riichi_club_key.path;
  };

  services.nginx.virtualHosts."riichi.negitorodon.de" = {
    forceSSL = false;
    enableACME = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:5000";
      proxyWebsockets = true;
    };
  };

}
