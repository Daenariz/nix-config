{ inputs, pkgs, ... }:

{
  imports = [
    inputs.core.homeModules.hyprland
    inputs.core.homeModules.styling
    # inputs.core.packages.${pkgs.system}
    ./programs.nix
    ./services.nix
    ./wbarsettings.nix
    # ./rclone.nix
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
