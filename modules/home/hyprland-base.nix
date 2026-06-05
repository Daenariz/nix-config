{
  lib,
  pkgs,
  ...
}: {
  wayland.windowManager.hyprland.settings = {
    general = {
      no_border_on_floating = lib.mkDefault true;
      gaps_in = lib.mkDefault 3;
      gaps_out = lib.mkDefault 6;
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
