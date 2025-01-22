{ inputs, pkgs, ... }:

let
  corepkgs = inputs.core.packages.${pkgs.system};
in
{
  environment = {
    systemPackages = [
    ];
  };
}
