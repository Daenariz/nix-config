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
    inputs.nix-flatpak.homeManagerModules.nix-flatpak

    ./packages.nix
    ./programs.nix
  ];

    programs.waybar.settings = import ./settings/waybar.nix;

  wayland.windowManager.hyprland = {
    enable = true;
    autostart = true;
        settings = import ./settings/hyprland.nix { inherit pkgs ; };
  };

  services.ssh-agent.enable = true;

  home.shellAliases = {
    search-store = "find /nix/store -maxdepth 1 -type d | rg -i ";

    go2config = "cd ~/.config/nixos/";
    go2hyprland = "cd ~/.config/nixos/users/neo/home/hyprland/";
    # go2core = "cd ~/Desktop/repos/nix-core/";
  };

  home.sessionVariables = lib.mkAfter {
    ELECTRON_OZONE_PLATFORM_HINT = "wayland"; # to fix flickering
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  services = {
    hyprpaper = {
      enable = true;
      settings = {
        preload = lib.mkForce [ "~/Pictures/nixos-wallpaper-catppuccin-frappe.png" ];
        wallpaper = lib.mkForce [ ",~/Pictures/nixos-wallpaper-catppuccin-frappe.png" ];
      };
    };

    hypridle = {
      enable = true;
      settings = import ./settings/hypridle.nix;
    };
  };



  services.flatpak = {
    enable = true;
    update = {
      onActivation = false;
      auto = {
        enable = true;
        onCalendar = "weekly";
      };
    };
    packages = [
      #      {
      #  appId = "us.zoom.Zoom";
      #  origin = "flathub";
      #}
      {
        appId = "com.usebottles.bottles";
        origin = "flathub";
      }

    ];
  };

  home.packages = [ pkgs.flatpak ];

    styling.enable = true;
}
