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
  imports = [
    inputs.synix.nixosModules.nginx
    inputs.synix.nixosModules.open-webui-oci
    inputs.synix.nixosModules.mailserver
    inputs.synix.nixosModules.coturn
    inputs.synix.nixosModules.matrix-synapse
    inputs.synix.nixosModules.headscale
    inputs.synix.nixosModules.radicale

    inputs.riichi-club.nixosModules.riichi-club

    outputs.nixosModules.vaultwarden
    outputs.nixosModules.nextcloud
    outputs.nixosModules.forgejo
    outputs.nixosModules.forgejo-runner
    # outputs.nixosModules.open-webui-oci

    ./nextcloud.nix
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "olm-3.2.16"
  ];

  services.radicale.enable = true;
  services.radicale.users = [ "susagi" ];
  services.radicale.reverseProxy.enable = true;

  services.riichi_club = {
    enable = true;
    nginx.subdomain = "riichi";
    secretKey = config.sops.secrets.riichi_club_key.path;
  };

  services.tailscale.enable = true;

  services.forgejo.enable = true;
  services.forgejo.stateDir = "/data/forgejo";

  services.forgejo-runner = {
    enable = true;
    url = config.services.forgejo.settings.server.ROOT_URL;
    tokenFile = config.sops.templates."forgejo_runner_token".path;
  };

  services.headscale = {
    enable = true;
    openFirewall = true;
    reverseProxy = {
      enable = true;
      subdomain = "head";
    };
    settings = {
      dns = {
        magic_dns = true;
      };
    };
  };

  services.uptime-kuma.enable = true;

  services.nginx.virtualHosts."kuma.kokushi-musou.de" = {
    forceSSL = true;
    enableACME = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:3001";
      proxyWebsockets = true;
      recommendedProxySettings = true;
    };
  };

  mailserver.enable = true;
  mailserver.stateVersion = 3;
  mailserver.accounts = {
    susagi = {
      aliases = [ "postmaster@${domain}" ];
    };
  };

  services.coturn = {
    enable = true;
    sops = true;
    openFirewall = true;
  };

  services.matrix-synapse = {
    enable = true;
    sops = true;
    coturn.enable = true;
    # dataDir = "/data/matrix-synapse";
    bridges = {
      whatsapp.enable = true;
      whatsapp.admin = "@susagi:${domain}";
      signal.enable = true;
      signal.admin = "@susagi:${domain}";
    };
  };

  services.vaultwarden.enable = true;
  services.vaultwarden.reverseProxy = {
    enable = true;
    subdomain = "vault";
  };

  services.open-webui-oci.enable = true;
  services.open-webui-oci.port = 8083;
  services.open-webui-oci.externalUrl = "https://ai.${domain}";

  services.nginx.virtualHosts."ai.${domain}" = {
    forceSSL = true;
    enableACME = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:8083";
      proxyWebsockets = true;
    };
  };

  services.nginx.virtualHosts."riichi.kokushi-musou.de" = {
    forceSSL = true;
    enableACME = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:5000";
      proxyWebsockets = true;
    };
  };

  services.nginx.enable = true;

  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
      flags = [ "--all" ];
    };
  };

  virtualisation.containers.storage.settings = {
    storage = {
      driver = "overlay";
      runroot = "/run/containers/storage";
      graphroot = "/data/podman";
    };
  };
}
