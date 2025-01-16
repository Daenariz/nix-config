{
  imports = [ ../../hyprland ];

  wayland.windowManager.hyprland.extraConfig = import ./monitors.nix;
}
