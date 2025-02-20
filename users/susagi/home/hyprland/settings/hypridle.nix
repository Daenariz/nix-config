{
  general = {
    before_sleep_cmd = "loginctl lock-session"; # lock before suspendafter_sleep_cmd
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
}
