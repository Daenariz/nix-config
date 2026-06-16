{
  imports = [ ../../hyprland ];

  wayland.windowManager.hyprland.extraConfig = import ./monitors.nix;
  #programs.waybar.settings.mainBar.output = "eDP-1";
}
