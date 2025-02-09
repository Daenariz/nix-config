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
    inputs.core.nixosModules.mailserver
    inputs.core.nixosModules.nextcloud
    inputs.core.nixosModules.nginx
    # inputs.core.nixosModules.open-webui
    # outputs.nixosModules.peertube

    # outputs.nixosModules.vaultwarden
    inputs.core.nixosModules.rss-bridge
    inputs.core.nixosModules.tt-rss
  ];

  mailserver = {
    enable = true;
    loginAccounts = {
      "susagi@${config.networking.domain}" = {
        hashedPasswordFile = config.sops.secrets."mailserver/accounts/susagi".path;
        aliases = [ "postmaster@${config.networking.domain}" ];
      };
    };
  };

  sops.secrets."mailserver/accounts/susagi" = { };

  services.nextcloud = {
    enable = true;
    datadir = "/data/nextcloud";
    subdomain = "cloud";
    #appstoreEnable = lib.mkForce true; # overwriting default # I really do not recommend this, especially together with `extraApps`. -Sid
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps)
        bookmarks
        calendar
        contacts
        mail
        tasks
        #        files_accesscontrol
        ;
    };
  };
  # services.vaultwarden = {
  #   enable = true;
  #   subdomain = "vault";
  # };
  # services.peertube = {
  #   enable = false;
  #   subdomain = "videos";
  #   dataDirs = [ "/data/peertube" ];
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
}
