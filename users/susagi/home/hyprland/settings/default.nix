{

  wayland.windowManager.hyprland = {
    enable = true;
    autostart = true;
    settings = import ./hyprland.nix;
  };
}
