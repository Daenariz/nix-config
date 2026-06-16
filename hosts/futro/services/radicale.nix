{ inputs, ... }:
{
  imports = [
    inputs.synix.nixosModules.radicale
  ];

  services.radicale.enable = true;
  services.radicale.users = [ "susagi" ];
  services.radicale.reverseProxy.enable = true;
  services.radicale.reverseProxy.subdomain = "dav";
  services.radicale.reverseProxy.forceSSL = false;
}
