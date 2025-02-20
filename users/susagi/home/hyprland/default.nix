{ inputs, pkgs, ... }:

{
  imports = [
    inputs.core.homeModules.hyprland
    inputs.core.homeModules.styling
    ./programs.nix
    ./services.nix
    ./settings
  ];

  styling = {
    enable = true;
    scheme = "dracula";
  };


  home.packages = import ./packages.nix { inherit pkgs; };
}
