{
  pkgs,
  lib,
  inputs,
  ...
}:

{
  imports = [
    inputs.core.homeModules.hyprland
    inputs.core.homeModules.styling
    #1# inputs.nixcord.homeModules.nixcord

    ./packages.nix
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    autostart = true;
  };

  programs.librewolf = {
    profiles.default = {
      extensions.packages = lib.mkAfter (
        with inputs.nur.legacyPackages."${pkgs.system}".repos.rycee.firefox-addons;
        [
          bitwarden
          yomitan
        ]
      );
    };
  };
  
  home.shellAliases = { 
    search-store = "find /nix/store -maxdepth 1 -type d | rg -i ";
      
    go2config = "cd ~/.config/nixos/";
    go2hyprland = "cd ~/.config/nixos/users/neo/home/hyprland/";
    # go2core = "cd ~/Desktop/repos/nix-core/";
  };

  #1# programs.nixcord.enable = true;

  styling.enable = true;
}
