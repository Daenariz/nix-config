{ pkgs, lib,  ... }:

{
 general = {
     no_border_on_floating = true; 
     gaps_in = lib.mkForce 3;
     gaps_out = lib.mkForce 6;
   };

  animations.enabled = true;
  #gestures.workspace_swipe = true;  ## also deprecated
  # probably changed in 24.11
  # decoration = {
  #   blur.enabled = true;
  #   shadow.enabled = true;
  # };

  bind =
    let
      flatpak = "${pkgs.flatpak}/bin/flatpak";
      bw-menu = "${pkgs.bitwarden-menu}/bin/bwm";
      tidal = "${pkgs.tidal-hifi}/bin/tidal-hifi";
      app-browser = "${pkgs.brave}/bin/brave";  ### seems to work for chromium-based browsers like brave, ungoogled-chromium
    in
    [
      "$mod,       z, exec, super-productivity --ozone-platform=x11"
      "$mod,       t, exec, ${tidal}"
      "$mod CTRL,  j, exec, joplin-desktop"
      "$mod CTRL, m, exec, ${app-browser} --app=https://tenhou.net/3/"
    ];

  exec-once = [
    "fcitx5 -d -r" # https://nixos.wiki/wiki/Fcitx5 for Hyprland usage
    "fcitx5-remote -r"
    "[workspace 2 silent] librewolf"
    "[workspace 4 silent] thunderbird"
    "[workspace 5 silent] element-desktop"
    "[workspace 5 silent] signal-desktop"
  ];

  windowrule = [
    "center (1), class:^(dmenu)$"
    "workspace 2, class:^([Ll]ibrewolf)$"
    "workspace 4, class:^thunderbird$, title:Thunderbird$"
    "workspace 5, class:^Element$, title:^Element"
    "workspace 5, title:^Signal"
    "workspace 6, initialClass:^tidal-hifi$, initialTitle:^tidal-hifi"
  ];
  workspace = [
    "1, monitor:eDP-1, default:true"
    "2, monitor:DP-6"
    #"2, monitor:HDMI-1-A, default:true, layoutopt:orientation:top"
    "3, monitor:eDP-1"
    "4, monitor:eDP-1"
    "5, monitor:DP-3"
    "6, monitor:eDP-1"
    "7, monitor:eDP-1"
  ];
}
