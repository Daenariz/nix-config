{
  inputs,
  config,
  outputs,
  lib,
  ...
}:

{
  imports = [
    inputs.core.nixosModules.openssh
    inputs.core.nixosModules.nginx
    # inputs.core.nixosModules.open-webui
    # outputs.nixosModules.vaultwarden
    inputs.core.nixosModules.rss-bridge
    inputs.core.nixosModules.tt-rss
  ];

  # services.vaultwarden = {
  #   enable = true;
  #   subdomain = "vault";
  # };
  services.nginx.enable = true;
  services.openssh = {
    enable = true;
    ports = [ 3407 ];
  };
  # services.open-webui.enable = true;
  services.rss-bridge = {
    enable = true;
    dataDir = "/data/rss-bridge";
    subdomain = "rss-bridge";
  };
  services.tt-rss = {
    enable = true;
    root = "/data/tt-rss";
  };
  services.home-assistant = {
    enable = true;
    extraComponents = [
      "analytics"
      "google_translate"
      "met"
      "radio_browser"
      "shopping_list"
    ];
    config = {
      default_config = { };
    };
  };
}
