{
  config,
  lib,
  pkgs,
  ...
}:
{
  virtualisation = {
 #   docker = {
 #     enable = true;
 #     daemon.settings = {
        # ## see https://nixos.wiki/wiki/Docker
 #       userland-proxy = false;
        #experimental = true;
        #metrics-addr = "0.0.0.0:9323";
        #ipv6 = true;
        #fixed-cidr-v6 = "fd00::/80";
 #     };
 #   };

    oci-containers = {
      backend = "docker";
      containers = {
        home-assistant = {
          image = "ghcr.io/home-assistant/home-assistant:main";
          volumes = [ "home-assistant:/config" ];
          autoStart = true;
          extraOptions = ["--network=host"];
        };
      };
    };
  };
}
