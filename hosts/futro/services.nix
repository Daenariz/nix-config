{
  pkgs,
  inputs,
  outputs,
  config,
  ...
}:
let
  domain = config.networking.domain;
in
{
  ### coturn + headscale /atm. without settings.dns.magic_dns) running now on edge server
  imports = [
    inputs.synix.nixosModules.mailserver
    # inputs.synix.nixosModules.headscale

    # inputs.riichi-club.nixosModules.riichi-club

    outputs.nixosModules.forgejo
    # outputs.nixosModules.forgejo-runner

  ];

 
  # services.riichi_club = {
  #   enable = true;
  #   nginx.subdomain = "riichi";
  #   secretKey = config.sops.secrets.riichi_club_key.path;
  # };

  services.forgejo.enable = true;
  services.forgejo.stateDir = "/data/forgejo";

  services.forgejo-runner = {
    enable = true;
    url = config.services.forgejo.settings.server.ROOT_URL;
    tokenFile = config.sops.templates."forgejo_runner_token".path;
  };

    # services.uptime-kuma.enable = true;
  #
  # services.nginx.virtualHosts."kuma.kokushi-musou.de" = {
  #   forceSSL = true;
  #   enableACME = true;
  #   locations."/" = {
  #     proxyPass = "http://127.0.0.1:3001";
  #     proxyWebsockets = true;
  #     recommendedProxySettings = true;
  #   };
  # };

  mailserver.enable = true;
  mailserver.stateVersion = 3;
  mailserver.accounts = {
    susagi = {
      aliases = [ "postmaster@${domain}" ];
    };
  };
 
  # services.nginx.virtualHosts."riichi.negitorodon.de" = {
  #   forceSSL = false;
  #   enableACME = true;
  #   locations."/" = {
  #     proxyPass = "http://127.0.0.1:5000";
  #     proxyWebsockets = true;
  #   };
  # };
 }
