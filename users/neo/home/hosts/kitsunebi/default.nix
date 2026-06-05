{
  imports = [ ../../hyprland ];

  wayland.windowManager.hyprland.extraConfig = import ./monitors.nix;
  programs.waybar.settings.mainBar.output = "HDMI-A-1";
}
