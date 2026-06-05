{
  inputs,
  config,
  outputs,
  lib,
  ...
}: {
  imports = [
    inputs.synix.nixosModules.openssh
    inputs.synix.nixosModules.mailserver
    inputs.synix.nixosModules.nextcloud
    inputs.synix.nixosModules.nginx
    #    inputs.synix.nixosModules.open-webui
    inputs.synix.nixosModules.vaultwarden
    inputs.synix.nixosModules.rss-bridge
    inputs.synix.nixosModules.tt-rss
    inputs.ha-test.nixosModules.home-assistant-oci
    inputs.synix.nixosModules.matrix-synapse
  ];

  services.matrix-synapse = {
    enable = false;
    dataDir = "/data/matrix-synapse";
    bridges = {
      whatsapp = {
        enable = false;
        admin = "@susagi:${config.networking.domain}";
        #      signal.enable = true;
      };
    };
  };

  # services.home-assistant-oci = {
  #   enable = false
  #   dataDir = "/data/home-assistant";
  # };

  mailserver = {
    enable = false;
    loginAccounts = {
      "susagi@${config.networking.domain}" = {
        hashedPasswordFile = config.sops.secrets."mailserver/accounts/susagi".path;
        aliases = ["postmaster@${config.networking.domain}"];
      };
    };
  };

  sops.secrets."mailserver/accounts/susagi" = {};

  services.nextcloud = {
    enable = false;
    datadir = "/data/nextcloud";
    subdomain = "cloud";
    extraApps = {
      inherit
        (config.services.nextcloud.package.packages.apps)
        bookmarks
        calendar
        contacts
        mail
        tasks
        ;
    };
  };
  services.vaultwarden = {
    enable = false;
    subdomain = "vault";
  };
  services.nginx.enable = false;
  # services.open-webui.enable = true;
  services.rss-bridge = {
    enable = false;
    dataDir = "/data/rss-bridge";
    subdomain = "rss-bridge";
  };
  services.tt-rss = {
    enable = false;
    root = "/data/tt-rss";
  };
}
