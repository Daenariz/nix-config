{
  lib,
  pkgs,
  ...
}: {
  general = {
    no_border_on_floating = true;
    gaps_in = lib.mkDefault 3;
    gaps_out = lib.mkDefault 6;
  };

  animations = {
    enabled = lib.mkDefault true;
  };

  decoration = {
    rounding = lib.mkDefault 10;
    blur.enabled = lib.mkDefault true;
    shadow.enabled = lib.mkDefault true;
  };

  # Common window rules that make sense for everyone
  windowrule = [
    "center (1), class:^(dmenu)$"
  ];
}
