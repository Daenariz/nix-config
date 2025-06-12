{
lib,
     inputs,
  pkgs,
  ...
}:

{
  imports = [
    inputs.core.homeModules.hyprland
    inputs.core.homeModules.styling
    inputs.core.homeModules.virtualization

    ./flatpak.nix
    ./programs.nix
    ./services.nix
    ./hypr.nix
    ./ssh.nix
  ];

  styling = {
    enable = true;
    scheme = "dracula";
  };
  #  programs.librewolf.searchEngines = [
  #  howlongtobeat
  #];

  wayland.windowManager.hyprland = {
    enable = true;
    autostart = true;
    settings = import ./settings/hyprland.nix { inherit pkgs; };
  };

  home.packages = import ./packages.nix { inherit pkgs inputs; };
  home.sessionVariables = lib.mkAfter {
    AQ_NO_MODIFIERS = "1";  # for DisplayLink monitors
  };

  home.shellAliases = {
    t2c = "sh ~/Desktop/projects/repos/soku_tango/tango2csv.sh ";
    search-store = "find /nix/store -maxdepth 1 -type d | rg -i ";

    go2config = "cd ~/.config/nixos/";
    go2hyprland = "cd ~/.config/nixos/users/susagi/home/hyprland/";
    go2core = "cd ~/Desktop/repos/nix-core/";
  };

}
