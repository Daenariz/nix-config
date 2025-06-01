{
  mainBar = {
    modules-left = [
      "hyprland/workspaces"
      "tray"
      "keyboard-state"
      "hyprland/window"
    ];
    modules-right = [
      "custom/timer"
      "custom/newsboat"
      "bluetooth"
      "network"
      "cpu"
      "memory"
      "disk"
      "pulseaudio#input"
      "pulseaudio#output"
    ];

    "hyprland/workspaces" = {
      "format" = " {icon} ";
      "format-icons" = {
        "1" = ""; # default
        "2" = ""; # browser
        "3" = ""; # discord
        "4" = ""; # steam
        "5" = ""; # chats
        "6" = ""; # music
        "urgent" = "";
        "active" = "";
        "default" = "";
      };

      tray = {
        "icon-size" = 21;
        "spacing" = 10;
      };

      "all-outputs" = false;
      "persistent-workspaces" = {
        "DP-1" = [
          1
          3
          4
          5
          6
        ];
        "HDMI-A-1" = [ 2 ];
      };
    };
  };
}
