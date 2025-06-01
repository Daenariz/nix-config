{ lib, pkgs, ... }:
{
  general = lib.mkForce {
    no_border_on_floating = true;
    gaps_in = 3;
    gaps_out = 6;
  };

  animations = {
    enabled = true;
    #    first_launch_animation = true;
  };

  decoration = lib.mkForce {
    rounding = 10;
    # dim_inactive = true;
    blur.enabled = true;
    shadow.enabled = true;
  };

  exec-once = [
    "fcitx5 -d && polychromatic-tray-applet" # -r , https://nixos.wiki/wiki/Fcitx5 for Hyprland usage
    #"fcitx5-remote -r"
    "[workspace 2 silent] librewolf"
    "[workspace 3 silent] vesktop"
    "[workspace 4 silent] steam"
    "[workspace 5 silent] element-desktop"
    "[workspace 6 silent] tidal-hifi"
  ];

  bind = [
    "$mod, r, pass, class:^(com\.obsproject\.Studio)$"
    "$mod,       z, exec, ${pkgs.flatpak}/bin/flatpak run com.usebottles.bottles"
  ];

  windowrule = lib.mkForce [

    # TODO: if new window created, split horizontally
    #    "monitor   0, class:^librewolf$"
    "workspace 2, class:^([Ll]ibrewolf)$"
    ### according to https://github.com/hyprwm/Hyprland/discussions/421#discussioncomment-13117082
    #"pseudo, fcitx"

    "workspace 3, class:^([Dd]iscord|[Ww]ebCord|[Vv]esktop)$"
    "opacity 0.80 0.80, class:^([Vv]esktop)$"

    "workspace 4, class:^([Ss]team)$"
    "float, class:^([Ss]team)$" # , title:negative:^([Ss]team)$"
    "center, title:^(Special Offers|Sign in to Steam)$"

    #"pseudo, class:^([Ss]team)$"
    ##"size 1636 1048, title:^([Ss]team)$" # resize correctly
    ##"move 0 32, title:^([Ss]team)$"  # works for now, but makes no sense
    #"workspace 4, title:^(Friends List)$"
    #  "float, title:^(Friends List)$"
    "size 284 1054, title:^(Friends List)$"
    "move 1636 26, title:^(Friends List)$" # same here
    "size 1636 1054, title:^([Ss]team)$" # resize correctly
    "move 0 26, title:^([Ss]team)$" # works for now, but makes no sense

    #"monitor   1, class:^Element$, title:^Element"
    "workspace 5, class:^(im.riot.Riot)$"

    #"monitor   1, class:^tidal-hifi$, title:^tidal-hifi"
    "workspace 6, class:^(tidal-hifi)$"

    ### smart gaps?
    "bordersize 0, floating:0, onworkspace:w[tv1]"
    "rounding 0, floating:0, onworkspace:w[tv1]"
    "bordersize 0, floating:0, onworkspace:f[1]"
    "rounding 0, floating:0, onworkspace:f[1]"

    ##games
    # TODO: GW2 steam_app_1284210 needs a center
    #"float, class:^steam_app_1284210$"
    "monitor 2, class:^(steam_app_\d+)$"
    "workspace 1, class:^(steam_app_\d+)$"
    "pseudo, class:^(steam_app_\d+)$"
    "allowsinput 1, class:^(steam_app_\d+)$"
    "center, class:^(steam_app_\d+)$"
    # "move center (1), class:^steam_app_1284210$, title:^Guild Wars 2$"

  ];
  workspace = [
    "1, monitor:DP-1" # , gapsout:10, gapsin:5"
    "2, monitor:HDMI-A-1, layoutopt:orientation:top"
    "3, monitor:DP-1"
    "4, monitor:DP-1"
    "5, monitor:DP-1"
    "6, monitor:DP-1"
    ### smart gaps
    "w[tv1], gapsout:0, gapsin:0"
    "f[1], gapsout:0, gapsin:0"
  ];
}
