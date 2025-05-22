{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tidal-hifi

    #    mangohud
    protonup-qt
    lutris
    heroic
    dualsensectl

        gpu-screen-recorder
    gpu-screen-recorder-gtk
    # razer + rgb stuff
    openrazer-daemon
    polychromatic
  ];
}
