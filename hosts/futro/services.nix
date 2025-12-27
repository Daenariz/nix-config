{
  inputs,
  outputs,
  config,
  lib,
  ...
}:
  let
  domain = config.networking.domain;
in
{
  imports = [
    inputs.core.nixosModules.nginx
    inputs.core.nixosModules.open-webui-oci
    inputs.core.nixosModules.vaultwarden
    inputs.core.nixosModules.mailserver
    inputs.core.nixosModules.matrix-synapse
    inputs.core.nixosModules.nextcloud
    inputs.core.nixosModules.headscale
    inputs.core.nixosModules.tailscale

  ];
  
  services.tailscale = {
    enable = true;
    enableSSH = true;
    loginServer = "https://head.negitorodon.de";
  };

  services.headscale = {
    enable = true;
    openFirewall = true;
    reverseProxy = {
      enable = true;
      subdomain = "head";
    };
  };

  services.uptime-kuma.enable = true;

  services.nginx.virtualHosts."kuma.${domain}" = {
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
    reverseProxy = {
      enable = true;
      subdomain = "cloud";
    };
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps)
        bookmarks
        calendar
        contacts
        richdocuments
        tasks
        ;
    };
    settings = {
      richdocuments = {
        wopi_url = "https://office.${domain}";
      };
    };
  };

  services.collabora-online = {
    enable = true;
    port = 9980;
    settings = {
      # rely on reverse proxy for SSL
      ssl = {
        enable = false;
        termination = true;
      };
      storage.wopi = {
        "@allow" = true;
        host = [ "cloud.${domain}" ];
      };
      server_name = "office.${domain}";
    };
  };

  services.nginx.virtualHosts."office.${domain}" = {
    forceSSL = true;
    enableACME = true;
    locations."/" = {
      proxyPass = "http://127.0.0.1:${toString config.services.collabora-online.port}";
      proxyWebsockets = true;
    };
  };

  mailserver = {
    enable = true;
    stateVersion = 3;
    loginAccounts = {
      "susagi@${domain}" = {
        hashedPasswordFile = config.sops.secrets."mailserver/accounts/susagi".path;
        aliases = [ "postmaster@${domain}" ];
      };
    };
  };

  services.matrix-synapse = {
    enable = true;
    dataDir = "/data/matrix-synapse";
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
  services.open-webui-oci.reverseProxy.enable = true;

# services.nginx = {
#   virtualHosts."ai.${domain}" = {
#     locations."/" = {
#       extraConfig = ''
#         proxy_buffering off;
#         proxy_cache off;
#         chunked_transfer_encoding on;
#         proxy_read_timeout 300s;
#       '';
#     };
#   };
# };
  services.nginx.enable = true;

}
