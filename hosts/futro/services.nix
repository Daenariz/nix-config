{
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
    # inputs.synix.nixosModules.tailscale

    outputs.nixosModules.vaultwarden
    outputs.nixosModules.nextcloud
    outputs.nixosModules.forgejo
    # outputs.nixosModules.open-webui-oci
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "olm-3.2.16"
  ];

  # services.tailscale = {
  #   enable = true;
  #   enableSSH = true;
  #   loginServer = "https://head.negitorodon.de";
  # };
  services.forgejo.enable = true;
  services.forgejo.stateDir = "/data/forgejo";

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

      net.alias_groups = {
      group1 = {
        host = [ "cloud.${domain}" ];
      };
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

  services.nginx.enable = true;
}
