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
    "[workspace 1] kitty"
    "[workspace 2 silent] librewolf"
    "[workspace 4 silent] thunderbird"
    "[workspace 5 silent] element-desktop"
    "[workspace 5 silent] signal-desktop"
    "[workspace 6 silent] tidal-hifi"
  ];

  windowrulev2 = [
    "monitor   1, class:^librewolf$"
    "workspace 2, class:^librewolf$"

    "monitor   0, class:^Element$, title:^Element"
    "workspace 5, class:^Element$, title:^Element"

    "monitor   0, class:^thunderbird$, title:Thunderbird$"
    "workspace 4, class:^thunderbird$, title:Thunderbird$"

    "monitor   0, class:^signal$, title:^Signal"
    "workspace 5, title:^Signal"

    "monitor   0, class:^tidal-hifi$, title:^tidal-hifi"
    "workspace 6, title:^TIDAL"
  ];
  workspace = [
    "r[2], monitor:HDMI-1-A, default:true"
    "r[3], monitor:eDP-1"
  ];
}
