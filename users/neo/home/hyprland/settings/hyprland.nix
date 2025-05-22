{ lib, pkgs, ...}:
{
  general = lib.mkForce{
    no_border_on_floating = true;
    gaps_in = 2;
    gaps_out = 4;
  };

  animations = {
    enabled = true;
    first_launch_animation = true;
  };

  #gestures.workspace_swipe = true;
  # probably changed in 24.11
   decoration = lib.mkForce {
     rounding = 10;
    # dim_inactive = true;
     blur.enabled = true;
     shadow.enabled = true;
   };

  exec-once = [
    "fcitx5 -d "   # -r , https://nixos.wiki/wiki/Fcitx5 for Hyprland usage
    #"fcitx5-remote -r"
    "polychromatic-tray-applet"
    "[workspace 2 silent] librewolf"
    "[workspace 3 silent] vesktop"
    "[workspace 4 silent] steam"
    "[workspace 5 silent] element-desktop"
    "[workspace 6 silent] tidal-hifi"
  ];

     bind = [
       "$mod,       z, exec, ${pkgs.flatpak}/bin/flatpak run com.usebottles.bottles"
      ];

  windowrule = [
    # TODO: if new window created, split horizontally
    #    "monitor   0, class:^librewolf$"
    "workspace 2, class:^([Ll]ibrewolf)$"

    ### according to https://github.com/hyprwm/Hyprland/discussions/421#discussioncomment-13117082
    #"pseudo, fcitx"

    "workspace 1, class:^([Kk]itty)$"
    "rounding 20, class:^([Kk]itty)$"
    "workspace 3, class:^([Dd]iscord|[Ww]ebCord|[Vv]esktop)$"

    "workspace    4, class:^([Ss]team)$"
    "float         , class:^([Ss]team)$" #, title:negative:^([Ss]team)$"
    "rounding    20, class:^([Ss]team)$"
    "size 1636 1048, title:^([Ss]team)$" # resize correctly
    "move      0 32, title:^([Ss]team)$"  # works for now, but makes no sense

    #"workspace 4, title:^(Friends List)$"
    #  "float, title:^(Friends List)$"
    "size 284 1048, title:^(Friends List)$"
    "move  1636 32, title:^(Friends List)$"  # same here

    #"monitor   1, class:^Element$, title:^Element"
    "workspace 5, class:^(im.riot.Riot)$"

    #"monitor   1, class:^tidal-hifi$, title:^tidal-hifi"
    "workspace 6, class:^(tidal-hifi)$"

    ### smart gaps?
    "bordersize 0, floating:0, onworkspace:w[tv1]"
    "rounding   0, floating:0, onworkspace:w[tv1]"
    "bordersize 0, floating:0, onworkspace:f[1]"
    "rounding   0, floating:0, onworkspace:f[1]"

    ##games
    # TODO: GW2 steam_app_1284210 needs a center
    #"float, class:^steam_app_1284210$"
    #"monitor 1, class:^(steam_app_\d+)$"
    "workspace 1, class:^(steam_app_\d+)$"
    #"center (1), class:^(steam_app_\d+)$"
    # "move center (1), class:^steam_app_1284210$, title:^Guild Wars 2$"

  ];
    workspace = [
    "2, monitor:HDMI-A-1, default:true, layoutopt:orientation:top" 
    "1, monitor:DP-1, default:true"#, gapsout:10, gapsin:5"
    "3, monitor:DP-1"  
    "4, monitor:DP-1"  
    "5, monitor:DP-1"  
    "6, monitor:DP-1"  
    ### smart gaps
    "w[tv1], gapsout:0, gapsin:0"
    "f[1], gapsout:0, gapsin:0"
    ];
}
