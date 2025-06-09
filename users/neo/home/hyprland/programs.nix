{
  lib,
  pkgs,
  inputs,
  ...
}:

let
  inherit (lib) mkForce mkAfter;
in
{
  programs = {
    obs-studio = {
      enable = true;
      package = (
        pkgs.obs-studio.override {
          cudaSupport = true;
        }
      );
      plugins = with pkgs.obs-studio-plugins; [
        advanced-scene-switcher
        wlrobs
      ];
    };
    mangohud = {
      enable = true;
      enableSessionWide = true;
      settings = {
        gamemode = true;
        output_folder = "/home/neo/Documents/mangologs";
      }; # https://github.com/flightlessmango/MangoHud/blob/master/data/MangoHud.conf
    };
    btop = {
      enable = true;
    };

    librewolf = {
      profiles.default = {
        extensions.packages = mkAfter (
          with inputs.nur.legacyPackages."${pkgs.system}".repos.rycee.firefox-addons;
          [
            bitwarden
            yomitan
          ]
        );
        search.engines = mkAfter {
          protondb = {
            urls = [ { template = "https://www.protondb.com/search?q={searchTerms}"; } ];
            icon = "https://www.protondb.com/favicon.ico";
            #updateInterval = every_day;
            definedAliases = [ "@pdb" ];
          };
          steamdb = {
            urls = [ { template = "https://steamdb.info/search/?a=all&q={searchTerms}"; } ];
            icon = "https://steamdb.info/favicon.ico";
            #updateInterval = every_day;
            definedAliases = [ "@stdb" ];
          };
          keyforsteam = {
            urls = [ { template = "https://www.keyforsteam.de/katalog/?search_name={searchTerms}"; } ];
            icon = "https://www.keyforsteam.de/favicon.ico";
            #updateInterval = every_day;
            definedAliases = [ "@k4s" ];
          };
        };
      };
    };

    vesktop = {
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

    kitty.settings.background_opacity = mkForce "0.3";
    # transparent nixvim plugin, only works with styling.scheme disabled since background color might be overwritten I guess
    nixvim.plugins.transparent.enable = mkForce true;
  };
}
