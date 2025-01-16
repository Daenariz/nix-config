{ outputs, pkgs, ... }:

{
  imports = [
    outputs.homeModules.hyprland
    outputs.homeModules.styling

    ./programs.nix
    ./services.nix
    ./wbarsettings.nix
  ];

  styling = {
    enable = true;
    scheme = "dracula";
  };

  wayland.windowManager.hyprland = {
    enable = true;
    autostart = true;
    settings = import ./settings;
  };

  home.packages = import ./packages.nix { inherit pkgs; };
}
