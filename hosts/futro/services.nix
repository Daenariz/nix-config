{
  inputs,
  outputs,
  config,
  ...
}:

{
  imports = [
    inputs.core.nixosModules.nginx
    inputs.core.nixosModules.open-webui
    inputs.core.nixosModules.vaultwarden
    inputs.core.nixosModules.mailserver
    inputs.core.nixosModules.matrix-synapse
    inputs.core.nixosModules.nextcloud
  ];

  services.uptime-kuma.enable = true;

  services.nginx.virtualHosts."kuma.negitorodon.de" = {
    forceSSL = true;
    enableACME = true;
    locations."/" = {
      proxyPass = "http://localhost:3001";
      proxyWebsockets = true;
      recommendedProxySettings = true;
    };
  };

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

  services.vaultwarden.enable = true;
  services.vaultwarden.subdomain = "vault";

  services.open-webui.enable = true;

  services.nginx.enable = true;

}
