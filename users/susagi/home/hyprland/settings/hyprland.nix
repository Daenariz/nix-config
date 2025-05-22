{ pkgs, ... }:

{
  animations.enabled = true;
  gestures.workspace_swipe = true;
  # probably changed in 24.11
  # decoration = {
  #   blur.enabled = true;
  #   shadow.enabled = true;
  # };

    bind =
   let
     flatpak = "${pkgs.flatpak}/bin/flatpak";
   in
   [
    "$mod,       z, exec, ${flatpak} run us.zoom.Zoom"
   ];

  exec-once = [
    "fcitx5 -d -r" # https://nixos.wiki/wiki/Fcitx5 for Hyprland usage
    "fcitx5-remote -r"
    "[workspace 2 silent] librewolf"
    "[workspace 4 silent] thunderbird"
    "[workspace 5 silent] element-desktop"
    "[workspace 5 silent] signal-desktop"
    "[workspace 6 silent] tidal-hifi"
  ];

  windowrule = [
    "monitor   1, initialClass:^librewolf$"
    "workspace 2, initialClass:^librewolf$"

    "monitor   0, class:^Element$, title:^Element"
    "workspace 5, class:^Element$, title:^Element"

    "monitor   0, class:^thunderbird$, title:Thunderbird$"
    "workspace 4, class:^thunderbird$, title:Thunderbird$"

    "monitor   0, class:^signal$, title:^Signal"
    "workspace 5, title:^Signal"

    "monitor   0, initialClass:^tidal-hifi$, initialTitle:^tidal-hifi"
    "workspace 6, initialClass:^tidal-hifi$, initialTitle:^tidal-hifi"
  ];
  workspace = [
    "1, monitor:eDP-1, default:true"
    "2, monitor:HDMI-1-A, default:true, layoutopt:orientation:top"
    "3, monitor:eDP-1"
    "4, monitor:eDP-1"
    "5, monitor:eDP-1"
    "6, monitor:eDP-1"
    "7, monitor:eDP-1"
  ];
}
