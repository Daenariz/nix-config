{
  config,
  lib,
  pkgs,
  ...
}:

with lib;

let
  cfg = config.virtualisation.oci-containers.containers.open-webui;
  fqdn = "ai.${config.networking.domain}";
  ssl = config.services.nginx.ssl;
in
{
  virtualisation = {
    docker = {
      # ## or maybe podman?
      enable = true;
      # rootless = {
      #     enable = true;
      #    setSocketVariable = true;
      #        };

      daemon.settings = {
        # ## see https://nixos.wiki/wiki/Docker
        userland-proxy = false;
        #experimental = true;
        #metrics-addr = "0.0.0.0:9323";
        #ipv6 = true;
        #fixed-cidr-v6 = "fd00::/80";
      };
    };

    oci-containers = {
      backend = "docker";
      containers = {
        open-webui = {
          image = "ghcr.io/open-webui/open-webui:main";
          ports = [ "3000:8080" ]; # #
          volumes = [ "open-webui:/app/backend/data" ];
          autoStart = true;
          ##extraOptions = ["--network=host"];
        };
      };
    };
  };
  #virtualisation.oci-containers.containers = {
  #  open-webui = {
  #    image = "ghcr.io/open-webui/open-webui:main";
  #    ports = [ "3000:8080" ];
  #    volumes = [ "open-webui:/app/backend/data" ];
  #    extraOptions = "--restart unless-stopped";
  #  };
  #};
  services.nginx.virtualHosts."${fqdn}" = {
    enableACME = true;
    forceSSL = true;
    locations."/".proxyPass = "http://localhost:3000";
  };

}
