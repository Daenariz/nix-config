{
  inputs,
  config,
  lib,
  ...
}:

{
  imports = [ inputs.core.homeModules.nextcloud-sync ];

  services.nextcloud-sync = {
    enable = true;
    remote = "cloud.negitorodon.de";
    passwordFile = config.sops.secrets.nextcloud.path;
    connections = [
      {
        local = "/home/susagi/Music";
        remote = "/auds";
      }
      {
        local = "/home/susagi/Documents";
        remote = "/docs";
      }
      {
        local = "/home/susagi/Pictures";
        remote = "/pics";
      }
      {
        local = "/home/susagi/Videos";
        remote = "/vids";
      }
      {
        local = "/home/susagi/Desktop/stud";
        remote = "/stud";
      }
    ];
  };

  services = {
    hyprpaper = {
      enable = true;
      settings = {
        preload = [ "~/Pictures/wallpaper.jpg" ];
        wallpaper = lib.mkForce [ ",~/Pictures/wallpaper.jpg" ];
      };
    };

    hypridle = {
      enable = true;
      settings = import ./settings/hypridle.nix;
    };

    ssh-agent.enable = true;
    # nextcloud-client.enable = true; # not working with sciebo atm
  };
}
