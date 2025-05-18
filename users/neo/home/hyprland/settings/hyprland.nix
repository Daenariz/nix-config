{
  animations.enabled = true;
  #gestures.workspace_swipe = true;
  # probably changed in 24.11
  # decoration = {
  #   blur.enabled = true;
  #   shadow.enabled = true;
  # };
  exec-once = [
    "fcitx5 -d -r"   # https://nixos.wiki/wiki/Fcitx5 for Hyprland usage
    "fcitx5-remote -r"
    "[workspace 2 silent] librewolf"
    "[workspace 3 silent] vesktop"
    "[workspace 4 silent] steam"
    "[workspace 5 silent] element-desktop"
    "[workspace 6 silent] tidal-hifi"
  ];

  windowrule = [
    # TODO: if new window created, split horizontally
    "monitor   0, class:^librewolf$"
    "workspace 2, class:^librewolf$"

    ### according to https://github.com/hyprwm/Hyprland/discussions/421#discussioncomment-13117082
    #"pseudo, fcitx"

    "monitor   1, class:^vesktop$, title:^Vesktop$"
    "workspace 3, class:^vesktop$, title:^Vesktop$"


    "workspace 4, initialTitle:^Steam$, title:^Friends List$"
    "float, class: ^steam$" 
    "size 1636 1048, initialTitle:^Steam$" # resize correctly
    "size 284 1048, title:^Friends List$"
    "move 0 32, initialTitle:^Steam$"  # works for now, but makes no sense
    "move 1636 32, title:^Friends List$"  # same here

    "monitor   1, class:^Element$, title:^Element"
    "workspace 5, class:^Element$, title:^Element"

    "monitor   1, class:^tidal-hifi$, title:^tidal-hifi"
    "workspace 6, title:^TIDAL"

    ### smart gaps?
    "bordersize 0, floating:0, onworkspace:w[tv1]"
    "rounding 0, floating:0, onworkspace:w[tv1]"
    "bordersize 0, floating:0, onworkspace:f[1]"
    "rounding 0, floating:0, onworkspace:f[1]"

    ##games
    # TODO: GW2 steam_app_1284210 needs a center
    #"float, class:^steam_app_1284210$"
    "move center (1), class:^steam_app_1284210$, title:^Guild Wars 2$"

  ];
    workspace = [
    "1, monitor:DP-1, default:true"
    "2, monitor:HDMI-A-1, default:true" 
    "r[3-6], monitor:DP-1"  
    ### smart gaps
    "w[tv1], gapsout:0, gapsin:0"
    "f[1], gapsout:0, gapsin:0"
    ];
}
