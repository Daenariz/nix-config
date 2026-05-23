{
  inputs,
  config,
  outputs,
  lib,
  ...
}:

{
  imports = [
    inputs.synix.nixosModules.mailserver
    inputs.synix.nixosModules.nextcloud
    inputs.synix.nixosModules.nginx
    inputs.synix.nixosModules.open-webui
    inputs.synix.nixosModules.vaultwarden
    inputs.synix.nixosModules.rss-bridge
    inputs.synix.nixosModules.tt-rss
    #    inputs.ha-test.nixosModules.home-assistant-oci
    inputs.synix.nixosModules.matrix-synapse
  ];

  services.matrix-synapse = {
    enable = true;
    dataDir = "/data/matrix-synapse";
    bridges = {
      whatsapp.enable = true;
      whatsapp.admin = "@susagi:${config.networking.domain}";
      #      signal.enable = true;
      #      signal.admin = "@susagi:${config.networking.domain}";
    };
  };

  #  services.home-assistant-oci = {
  #    enable = false;
  #    dataDir = "/data/home-assistant";
  #  };

  mailserver = {
    enable = true;
    stateVersion = 3;
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
