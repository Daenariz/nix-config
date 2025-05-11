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

  programs.vesktop = {
    enable = true;
    settings = {
      tray = true;
    };
  };

  styling.enable = true;
}
