{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

{
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
    #style = lib.mkForce (import ./style.nix { inherit config; });
    settings = import ./settings/waybar.nix;
  };

  programs.newsboat = {
    extraConfig = ''
      urls-source "ttrss"
      ttrss-url "https://tt-rss.negitorodon.de/"
      ttrss-login "susagi"
      ttrss-passwordfile "${config.sops.secrets.tt-rss.path}"
    '';
  };

  programs = {
    kitty.settings.background_opacity = lib.mkForce "0.5";
    # transparent nixvim plugin, only works with styling.scheme disabled since background color might be overwritten I guess
    nixvim.plugins.transparent.enable = lib.mkForce false;

    librewolf = {
      profiles.default = {
        #        settings = lib.mkAfter {
        # "browser.tabs.allow_transparent_browser" = true;
        # "browser.tabs.crashReporting.sendReport" = false;
        #};
        extensions.packages = lib.mkAfter (
          with inputs.nur.legacyPackages."${pkgs.system}".repos.rycee.firefox-addons;
          [
            bitwarden
            yomitan
            tabliss
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
