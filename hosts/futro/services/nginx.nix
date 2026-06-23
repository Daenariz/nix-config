{ inputs, ... }:
let
  ip = "100.64.0.3";
in
{
  imports = [ inputs.synix.nixosModules.nginx ];

  services.nginx = {
    enable = true;
    forceSSL = false;
    openFirewall = false; # only reachable via Tailnet
    defaultListen = [
      {
        addr = ip;
        port = 80;
      }
    ];
  };

  # nginx listens on the Tailnet IP — restart it after tailscaled comes up
  # so the IP is available. Also restart nginx if tailscaled restarts.
  systemd.services.nginx = {
    after = [ "tailscaled-autoconnect.service" ];
    wants = [ "tailscaled-autoconnect.service" ];
    bindsTo = [ "tailscaled.service" ];
  };
}
