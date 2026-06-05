{
  inputs,
  config,
  outputs,
  lib,
  ...
}:
{
  imports = [
    inputs.synix.nixosModules.openssh
    inputs.synix.nixosModules.nginx
    # inputs.synix.nixosModules.open-webui
    # outputs.nixosModules.vaultwarden
    inputs.synix.nixosModules.rss-bridge
    inputs.synix.nixosModules.tt-rss
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
