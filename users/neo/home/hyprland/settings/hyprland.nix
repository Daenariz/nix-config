{ lib, pkgs, ... }:
{
  general = lib.mkForce {
    no_border_on_floating = true;
    gaps_in = 3;
    gaps_out = 6;
  };

  animations = {
    enabled = true;
  };

  decoration = lib.mkForce {
    rounding = 10;
    blur.enabled = true;
    shadow.enabled = true;
  };

  exec-once = [
    "fcitx5 -d && polychromatic-tray-applet" 
    "obs --startreplaybuffer --minimize-to-tray" # -r , https://nixos.wiki/wiki/Fcitx5 for Hyprland usage
    "xrandr --output DP-1 --primary"
    "[workspace 3 silent] vesktop"
    "[workspace 4 silent] steam"
    "[workspace 5 silent] element-desktop"
  ];

  bind = [
    "$mod, r, pass, class:^(com\.obsproject\.Studio)$"
    "$mod,       z, exec, ${pkgs.flatpak}/bin/flatpak run com.usebottles.bottles"
  ];

  windowrule = lib.mkForce [

    # TODO: if new window created, split horizontally
    #    "monitor   0, class:^librewolf$"
    "workspace 6, class:^([Ll]ibrewolf)$"
    ### according to https://github.com/hyprwm/Hyprland/discussions/421#discussioncomment-13117082

    "workspace 3, class:^([Dd]iscord|[Ww]ebCord|[Vv]esktop)$"
    "opacity 0.80 0.80, class:^([Vv]esktop)$"

    "workspace 4, class:^([Ss]team)$"
    "float, class:^([Ss]team)$" # , title:negative:^([Ss]team)$"
    "center, title:^(Special Offers|Sign in to Steam)$"
    "size 284 1054, title:^(Friends List)$"
    "move 1636 26, title:^(Friends List)$" # same here
    "size 1636 1054, title:^([Ss]team)$" # resize correctly
    "move 0 26, title:^([Ss]team)$" # works for now, but makes no sense

    "workspace 5, class:^(im.riot.Riot)$"
    "workspace 2, class:^(tidal-hifi)$"

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
    # "pseudo, class:^(steam_app_\d+)$"
    ##    "allowsinput 1, class:^(steam_app_\d+)$"
    "center, class:^(steam_app_\d+)$"
    # "move center (1), class:^steam_app_1284210$, title:^Guild Wars 2$"

  ];
  workspace = [
    "1, monitor:DP-1, default:true" # , gapsout:10, gapsin:5"
    "2, monitor:DP-1"
    "3, monitor:DP-1"
    "4, monitor:DP-1"
    "5, monitor:DP-1"
    "6, monitor:HDMI-A-1, default:true, layoutopt:orientation:top"
    ### smart gaps
    "w[tv1], gapsout:0, gapsin:0"
    "f[1], gapsout:0, gapsin:0"
  ];
}
