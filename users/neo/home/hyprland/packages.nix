{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tidal-hifi

    mangohud
    protonup-qt
    lutris
    heroic
    # razer + rgb stuff
    openrazer-daemon
    polychromatic
  ];
}
