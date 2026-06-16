{
  inputs,
  config,
  ...
}:
let
  domain = config.networking.domain;
in
{
  imports = [ inputs.synix.nixosModules.open-webui-oci ];

  services.open-webui-oci.enable = true;
  services.open-webui-oci.port = 8083;
  services.open-webui-oci.externalUrl = "https://ai.${domain}";

  services.nginx.virtualHosts."ai.${domain}" = {
    forceSSL = false;
    locations."/" = {
      proxyPass = "http://100.64.0.3:8083";
      proxyWebsockets = true;
    };
  };
}
