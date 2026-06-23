{
  config,
  lib,
  outputs,
  ...
}:
let
  domain = config.networking.domain;
in
{
  imports = [
    outputs.nixosModules.nextcloud
  ];
  services.nextcloud = {
    enable = true;
    # package version managed in module
    datadir = "/data/nextcloud";
    https = lib.mkForce true;
    reverseProxy = {
      enable = true;
      subdomain = "cloud";
      forceSSL = false;
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
    #   settings = {
    #     richdocuments = {
    #       # TODO: needs to be tested, otherwise add manually at admin settings
    #       wopi_url = "localhost:9980";
    #       public_wopi_url = "https://office.${domain}";
    #     };
    #   };
    # };
    #
    # services.collabora-online = {
    #   enable = true;
    #   port = 9980;
    #   settings = {
    #     # rely on reverse proxy for SSL
    #     ssl = {
    #       enable = false;
    #       termination = true;
    #     };
    #     storage.wopi = {
    #       "@allow" = true;
    #       host = ["cloud.${domain}"];
    #     };
    #
    #     #   net.alias_groups = {
    #     #   group1 = {
    #     #     host = [ "cloud.${domain}" ];
    #     #   };
    #     # };
    #     server_name = "office.${domain}";
    #   };
    # };
    #
    # services.nginx.virtualHosts."office.${domain}" = {
    #   forceSSL = true;
    #   enableACME = true;
    #   locations."/" = {
    #     proxyPass = "http://100.64.0.3:${toString config.services.collabora-online.port}";
    #     proxyWebsockets = true;
    #   };
  };
}
