{ lib, inputs, pkgs, ... }:

{
  imports = [
    inputs.core.homeModules.hyprland
    inputs.core.homeModules.styling
    ./programs.nix
    ./services.nix
    #./settings
  ];
  
  services.mopidy = {
    enable = true;
    extensionPackages = [
      pkgs.mopidy-tidal  
    ];
  };

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

  home.shellAliases = { 
      t2c = "sh ~/Desktop/projects/repos/soku_tango/tango2csv.sh ";
      search-store = "find /nix/store -maxdepth 1 -type d | rg -i ";
    };
}
