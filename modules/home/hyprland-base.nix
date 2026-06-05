{
  lib,
  pkgs,
  ...
}:
{
  wayland.windowManager.hyprland.settings = {
    general = {
      no_border_on_floating = lib.mkForce true;
      gaps_in = lib.mkForce 3;
      gaps_out = lib.mkForce 6;
    };

    animations = {
      enabled = lib.mkDefault true;
    };

    # Common window rules that make sense for everyone
    windowrule = [
      "center (1), class:^(dmenu)$"
    ];
  };
}
