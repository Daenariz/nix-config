{
  pkgs ? import <nixpkgs>,
  ...
}:
{
  # example = pkgs.callPackage ./example { };
  plecs = pkgs.callPackage ./plecs { }; # x86_64-linux only
  # pi-sniffer = pkgs.callPackage ./pi-sniffer {};  # platform restricted
  bitpoll = pkgs.callPackage ./bitpoll { };
  riichi-city = pkgs.callPackage ./riichi-city { }; # x86_64-linux only
}
