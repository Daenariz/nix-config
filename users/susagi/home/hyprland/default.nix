{ lib, inputs, pkgs, ... }:

{
  imports = [
    inputs.core.homeModules.hyprland
    inputs.core.homeModules.styling

    inputs.core.homeModules.virtualization
    ./programs.nix
    ./services.nix
  ];
  
  services.mopidy = {
    enable = false;
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
      
      go2config = "cd ~/.config/nixos/";
      go2hyprland = "cd ~/.config/nixos/users/susagi/home/hyprland/";
      go2core = "cd ~/Desktop/repos/nix-core/";
    };

  programs.ssh = {
    enable = true;

    matchBlocks = {
      negitorodon = {
        host = "n negito";
        hostname = "negitorodon.de";
        port = 3407;
        user = "susagi";
        identityFile = "/home/susagi/.ssh/vde_rsa";
      };
    };
  };
}
