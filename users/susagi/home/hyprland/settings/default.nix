{

  programs.waybar = {
    #style = lib.mkForce (import ./style.nix { inherit config; });
    settings = import ./wbarsettings.nix;
  };

  wayland.windowManager.hyprland = {
    enable = true;
    autostart = true;
    settings = import ./hyprland.nix;
  };
}
