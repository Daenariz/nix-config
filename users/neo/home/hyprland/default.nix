{
  pkgs,
  lib,
  inputs,
  ...
}: {
  imports = [
    inputs.synix.homeModules.hyprland
    inputs.synix.homeModules.stylix
    inputs.nix-flatpak.homeManagerModules.nix-flatpak

    ./packages.nix
    ./programs.nix
  ];

  nixpkgs.config.allowUnfreePredicate = pkg:
    builtins.elem (lib.getName pkg) [
      "castlabs-electron"
      "zoom"
      "steam"
      "steam-unwrapped"
      "discord"
    ];

  programs.waybar.settings = import ./settings/waybar.nix;

  wayland.windowManager.hyprland = {
    enable = true;
    autostart = true;
    settings = import ./settings/hyprland.nix {inherit pkgs lib;};
  };

  services.ssh-agent.enable = true;

  home.shellAliases = {
    search-store = "find /nix/store -maxdepth 1 -type d | rg -i ";

    go2config = "cd ~/.config/nixos/";
    go2hyprland = "cd ~/.config/nixos/users/neo/home/hyprland/";
    # go2synix = "cd ~/Desktop/repos/nix-synix/";
  };

  home.sessionVariables = lib.mkAfter {
    ELECTRON_OZONE_PLATFORM_HINT = "wayland"; # to fix flickering
    LIBVA_DRIVER_NAME = "nvidia";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    NVD_BACKEND = "direct";
    # LD_PRELOAD = "/run/current-system/sw/lib/libgamemodeauto.so.0";
  };

  services = {
    hyprpaper = {
      enable = true;
      settings = {
        preload = [
          "~/Pictures/arknos.JPG"
          "~/Pictures/night.jpg"
          "~/Pictures/legends.JPG"
        ];
        wallpaper = [",~/Pictures/arknos.JPG"];
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

  stylix.enable = true;
}
