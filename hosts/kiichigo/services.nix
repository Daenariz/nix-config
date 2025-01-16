{
  config,
  outputs,
  lib,
  ...
}:

{
  imports = [
    outputs.nixosModules.openssh
    outputs.nixosModules.mailserver
    outputs.nixosModules.nextcloud
    # outputs.nixosModules.open-webui
    # outputs.nixosModules.peertube
    # outputs.nixosModules.rss-bridge
    # outputs.nixosModules.vaultwarden
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
    appstoreEnable = lib.mkForce true; # overwriting default # I really do not recommend this, especially together with `extraApps`. -Sid
    extraApps = {
      inherit (config.services.nextcloud.package.packages.apps)
        bookmarks
        calendar
        contacts
        mail
        tasks
        #files_external
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
}
