{ pkgs, ... }:

{
  home.packages = with pkgs; [
    tidal-hifi
    element-desktop
  ];
}
