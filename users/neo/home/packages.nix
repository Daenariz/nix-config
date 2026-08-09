{ pkgs, ... }:
{
  home.packages = with pkgs; [
    # temporary
    kitty
    yazi
    gnomeExtensions.tiling-shell

    android-tools
    discord
    # sonic-pi
    prismlauncher
    jdk25
    noto-fonts-cjk-sans # ファイアフォックスでは、日本語のかなを見せるのために
    tidal-hifi
    libva-utils
    sidequest
    ungoogled-chromium

    tor-browser

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

    # ai
    jan

    #test
    xorg.xrandr
    flatpak

    adwaita-icon-theme
  ];
}
