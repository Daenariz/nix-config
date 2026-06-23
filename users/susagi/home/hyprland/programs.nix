{
  inputs,
  lib,
  pkgs,
  ...
}:
{
  programs.aider-chat.enable = true;
  programs.aider-chat.settings = {
    model = "openrouter/google/gemini-2.5-pro";
    weak-model = "openrouter/google/gemini-3-flash-preview";
  };

  programs.anki.enable = true;
  programs.anki.addons = [ pkgs.ankiAddons.anki-connect ];

  programs.joplin-desktop = {
    enable = true;
    # package = pkgs.joplin;   ### for cli use eventually
    sync = {
      target = "nextcloud";
      interval = "30m";
    };
  };

  programs.vesktop = {
    enable = true;
    settings = {
      appBadge = false;
      arRPC = true;
      checkUpdates = false;
      customTitleBar = false;
      disableMinSize = true;
      minimizeToTray = false;
      tray = true;
      splashBackground = "#000000";
      splashColor = "#ffffff";
      splashTheming = true;
      staticTitle = true;
      hardwareAcceleration = true;
      discordBranch = "stable";
    };
  };

  programs.waybar = {
    settings = import ./settings/waybar.nix;
  };

  programs = {
    kitty.settings.background_opacity = lib.mkForce "0.5";
    # transparent nixvim plugin, only works with styling.scheme disabled since background color might be overwritten I guess
    nixvim.plugins.transparent.enable = lib.mkForce false;

    librewolf = {
      profiles.default = {
        # search.default = lib.mkForce "startpage@search.mozilla.orgdefault";
        #        settings = lib.mkAfter {
        # "browser.tabs.allow_transparent_browser" = true;
        # "browser.tabs.crashReporting.sendReport" = false;
        #};
        extensions.packages = lib.mkAfter (
          with inputs.nur.legacyPackages."${pkgs.system}".repos.rycee.firefox-addons;
          [
            adaptive-tab-bar-colour
            bitwarden
            yomitan
            sponsorblock
            darkreader
            floccus
          ]
        );
        # userChrome = lib.mkForce (
        #  ''
        #    :root {
        #      --corner-radius: 15px;
        #    }
        #  ''
        #  + (builtins.readFile ./userChrome.css)
        #);
        #userContent = lib.mkForce (builtins.readFile ./userContent.css);
      };
    };
  };
}
