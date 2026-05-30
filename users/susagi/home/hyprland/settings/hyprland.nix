{
  pkgs,
  lib,
  ...
}: {
  general = {
    no_border_on_floating = true;
    gaps_in = lib.mkForce 3;
    gaps_out = lib.mkForce 6;
  };

  animations.enabled = true;

  bind = let
    flatpak = "${pkgs.flatpak}/bin/flatpak";
    tidal = "${pkgs.tidal-hifi}/bin/tidal-hifi";
    app-browser = "${pkgs.brave}/bin/brave"; # ## seems to work for chromium-based browsers like brave, ungoogled-chromium
    nix-inspect = "${pkgs.nix-inspect}/bin/nix-inspect";
  in [
    "$mod SHIFT, minus, movecurrentworkspacetomonitor, u"
    "$mod, minus, movecurrentworkspacetomonitor, d"
    "$mod,       t, exec, ${tidal}"
    "$mod,       i, exec, ${nix-inspect}"
    "$mod CTRL,  j, exec, joplin-desktop"
    "$mod CTRL, m, exec, ${app-browser} --app=https://tenhou.net/3/"
  ];

  exec-once = [
    "fcitx5 -d -r" # https://nixos.wiki/wiki/Fcitx5 for Hyprland usage
    "fcitx5-remote -r"
    "[workspace 2 silent] librewolf"
    "sleep 5 && hyprctl dispatch exec '[workspace 4 silent] thunderbird'"
    "[workspace 5 silent] element-desktop"
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
