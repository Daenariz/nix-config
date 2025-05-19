{
  mainBar = {
    modules-left = [
      "hyprland/workspaces"
      "tray"
      "keyboard-state"
      "hyprland/language"
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
      "battery"
    ];

    "hyprland/workspaces" = {
      format = " {icon} ";
      format-icons = {
        "1" = ""; # default
        "2" = ""; # browser
        "3" = ""; # code
        "4" = ""; # mail
        "5" = ""; # chats
        "6" = ""; # music
        "7" = ""; # vm
        "urgent" = "";
        "active" = "";
        "default" = "";
      };

      tray = {
        "icon-size" = 21;
        "spacing" = 10;
      };

      all-outputs = false;
      persistent-workspaces."*" = 7;
    };
  };
}
