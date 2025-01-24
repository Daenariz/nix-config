{ inputs, pkgs, ... }:

let
  corepkgs = inputs.core.packages.${pkgs.system};
in
{
  environment = {
    systemPackages = with pkgs;[
      openconnect
      openconnect_openssl
      networkmanager-openconnect
    ];
  };
}
