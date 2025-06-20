{
  inputs,
  config,
  outputs,
  lib,
  ...
}:

{
  imports = [
    inputs.core.nixosModules.mailserver
    inputs.core.nixosModules.nextcloud
    inputs.core.nixosModules.nginx
    inputs.core.nixosModules.open-webui
    inputs.core.nixosModules.vaultwarden
    inputs.core.nixosModules.rss-bridge
    inputs.core.nixosModules.tt-rss
    inputs.ha-test.nixosModules.home-assistant-oci
    inputs.core.nixosModules.matrix-synapse
  ];

  services.matrix-synapse = {
    enable = true;
    dataDir = "/data/matrix-synapse";
    bridges = {
      whatsapp = {
        enable = true;
        admin = "@susagi:${config.networking.domain}";
        #      signal.enable = true;
      };
    };
  };

  services.home-assistant-oci = {
    enable = true;
    dataDir = "/data/home-assistant";
  };

  mailserver = {
    enable = true;
    loginAccounts = {
      "susagi@${config.networking.domain}" = {
        hashedPasswordFile = config.sops.secrets."mailserver/accounts/susagi".path;
        aliases = [ "postmaster@${config.networking.domain}" ];
      };
    };
  };

  sops.secrets."mailserver/accounts/susagi" = { };

  services.nextcloud = {
    enable = true;
    datadir = "/data/nextcloud";
    subdomain = "cloud";
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps)
        bookmarks
        calendar
        contacts
        mail
        tasks
        ;
    };
  };
  services.vaultwarden = {
    enable = true;
    subdomain = "vault";
  };

  services.nginx = {
    enable = true;
    virtualHosts =
      let
        webui = config.services.open-webui;
      in
      {
        "${webui.subdomain}.${config.networking.domain}" = {
          enableACME = true;
          forceSSL = true;
          locations."/" = {
            proxyPass = "http://192.168.178.107:8082";
            proxyWebsockets = true;
            extraConfig = ''
              proxy_set_header X-Accel-Buffering no;
              proxy_buffering off;
            '';
          };
        };
      };
  };

  services.rss-bridge = {
    enable = true;
    dataDir = "/data/rss-bridge";
    subdomain = "rss-bridge";
  };
  services.tt-rss = {
    enable = true;
    root = "/data/tt-rss";
  };
}
