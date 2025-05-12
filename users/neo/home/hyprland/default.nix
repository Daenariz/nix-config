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

  #1# programs.nixcord.enable = true;
  #  programs.nixcord = {
  # enable = false;  # enable Nixcord. Also installs discord package
    #  quickCss = "some CSS";  # quickCSS file
    #config = {
    #  useQuickCss = true;   # use out quickCSS
    # themeLinks = [        # or use an online theme
      # "https://betterdiscord.app/theme/New%20Akame%20Ga%20Kill!%20Theme"     ];
    # frameless = true; # set some Vencord options
    # plugins = {
    #   hideAttachments.enable = true;    # Enable a Vencord plugin
    #           ignoreActivities = {    # Enable a plugin and set some options
    #     enable = true;
    #     ignorePlaying = true;
    #     ignoreWatching = true;
    #     # ignoredActivities = [ "someActivity" ];
    #   };
    #  };
    #};
    #    extraConfig = {
    #  # Some extra JSON config here
    #  # ...
    #};
  # };

  styling.enable = true;
}
