# see https://wiki.hyprland.org/Configuring/Monitors/ for more
# https://home-manager-options.extranix.com/?query=wayland.windowManager.hyprland.extraConfig&release=release-24.05
# hyprctl monitors for more info
# hyprctl keyword monitor <name,res,pos,scale> for testing
# hyprctl reload for forcing config reload
''
  monitor = desc:Dell Inc. DELL S2721HGF 89M8123, 1920x1080@144, 0x0, 1.00
  monitor = desc:LG Electronics W2443 0x00036522, 1920x1080@60, 1920x-200, 1, transform, 1
''
# rotation with ..., transform, number from 1-3 (0 for default)
