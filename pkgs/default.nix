{
  pkgs ? import <nixpkgs>,
  ...
}:
{
  # example = pkgs.callPackage ./example { };
  # plecs = pkgs.callPackage ./plecs { }; # TEMPORARILY DISABLED: meta.platforms bug in package
  # pi-sniffer = pkgs.callPackage ./pi-sniffer {};  # platform restricted
  bitpoll = pkgs.callPackage ./bitpoll { };
  # riichi-city = pkgs.callPackage ./riichi-city { }; # TEMPORARILY DISABLED: meta.platforms double-nested bug
}
