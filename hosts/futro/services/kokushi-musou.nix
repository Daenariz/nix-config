{
  inputs,
  config,
  lib,
  ...
}:
{
  imports = [
    inputs.riichi-club.nixosModules.riichi-club
  ];

  services.riichi_club = {
    enable = true;
    nginx = {
      enable = false; # so upstream nginx config gets ignored for now
      subdomain = "riichi";
    };
    secretKey = config.sops.secrets.riichi_club_key.path;
  };
  # upstream values set in repo
  services.nginx.virtualHosts."riichi.negitorodon.de" = {
    # forceSSL = lib.mkForce false;
    forceSSL = false;
    enableACME = false;
    locations."/" = {
      # proxyPass = "http://127.0.0.1:5000";
      proxyPass = "http://100.64.0.3:5000";
      proxyWebsockets = true;
    };
  };

}
