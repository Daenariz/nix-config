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
      # for setting the wallpaper
      enable = true;
      settings = {
        preload = [ "~/Pictures/wallpaper.jpg" ];
        wallpaper = lib.mkForce [ ",~/Pictures/wallpaper.jpg" ];
      };
    };

    hypridle = {
      enable = true;
      settings = {
        general = {
          before_sleep_cmd = "loginctl lock-session"; # lock before suspend
          after_sleep_cmd = "hyprctl dispatch dpms on"; # to avoid having to press a key twice to turn on the display
          ignore_dbus_inhibit = false;
          lock_cmd = "pidof hyprlock || hyprlock"; # avoid starting multiple hyprlock instances
        };
        listener = [
          {
            timeout = 3000; # 50min in seconds
            on-timeout = "hyprlock";
          }
          # {
          #   timeout = 330; # 5.5min in seconds
          #   on-timeout = "hyprctl dispatch dpms off"; # turns off screen
          #   on-resume = "hyprctl dispatch dpms on"; # turns on screen
          # }
          # {
          #   timeout = 1800; # 30min
          #   on-timeout = "systemctl suspend"; # suspend pc
          # }
        ];
      };
    };
    ssh-agent.enable = true;
    # nextcloud-client.enable = true; # not working with sciebo atm
  };
}
