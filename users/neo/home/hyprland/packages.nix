{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tidal-hifi
    libva-utils
    sidequest
    ungoogled-chromium

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
