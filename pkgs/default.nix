{
  pkgs ? import <nixpkgs>,
  ...
}:

{
  # example = pkgs.callPackage ./example { };
  plecs = pkgs.callPackage ./plecs { };
  pi-sniffer = pkgs.callPackage ./pi-sniffer { };
}
