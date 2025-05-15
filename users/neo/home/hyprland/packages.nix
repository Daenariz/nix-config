{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tidal-hifi
    element-desktop

    mangohud
    protonup-qt
    lutris
    bottles
    heroic
  ];
}
