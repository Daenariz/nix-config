{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nixfmt
    ethtool
  ];
}
