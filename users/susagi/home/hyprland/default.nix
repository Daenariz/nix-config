{ inputs, pkgs, ... }:

{
  imports = [
    inputs.core.homeModules.hyprland
    inputs.core.homeModules.styling
    ./programs.nix
    ./services.nix
    #./settings
  ];

  styling = {
    enable = true;
    scheme = "dracula";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    autostart = true;
    settings = import ./settings/hyprland.nix;
  };

  home.packages = import ./packages.nix { inherit pkgs; };
}
