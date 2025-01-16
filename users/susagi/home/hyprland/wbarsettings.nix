{
  programs.waybar = {
    # style = lib.mkForce (import ./style.nix { inherit config; });
    settings = {
      mainBar = {
        modules-left = [
          "hyprland/workspaces"
          "tray"
          "keyboard-state"
          "hyprland/language"
          "hyprland/window"
        ];
        modules-right = [
          "bluetooth"
          "network"
          "cpu"
          "memory"
          "disk"
          "wireplumber"
          "battery"
        ]; # modules to show in the top bar at the right

        "hyprland/workspaces" = {
          format = " {icon} ";
          format-icons = {
            "1" = "";
            "2" = "";
            "3" = "";
            "4" = "";
            "5" = "";
            "6" = "";
            "urgent" = "";
            "active" = "";
            "default" = "";
          };

          tray = {
            "icon-size" = 21;
            "spacing" = 10;
          };

          all-outputs = false;
          persistent-workspaces."*" = 6;
        };
      };
    };
  };
}
