# see https://wiki.hyprland.org/Configuring/Monitors/ for more
# https://home-manager-options.extranix.com/?query=wayland.windowManager.hyprland.extraConfig&release=release-24.05
# hyprctl monitors for more info
# hyprctl keyword monitor <name,res,pos,scale> for testing
# hyprctl reload for forcing config reload
''
  monitor=,preferred,auto,1
  monitor = eDP-1, 1920x1200@60, 0x0, 1.25
  monitor = desc:Dell Inc. DELL P2412H TTMDG1932DKU, 1920x1080@60, -1080x0, 1, transform, 1
  monitor = desc:Fujitsu Siemens Computers GmbH B24T-7 LED PG YV6K204146, 1920x1080@60, -1080x0, 1, transform, 1
''
# rotation with ..., transform, number from 1-3 (0 for default)
