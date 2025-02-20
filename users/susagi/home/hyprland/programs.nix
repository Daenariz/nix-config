{
  config,
  inputs,
  lib,
  pkgs,
  ...
}:

{
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
      policies.Homepage.StartPage = lib.mkForce "previous-session";
      profiles.default = {
        extensions = lib.mkAfter (
          with inputs.nur.legacyPackages."${pkgs.system}".repos.rycee.firefox-addons;
          [
            bitwarden
          ]
        );
      };
    };

    ssh.addKeysToAgent = "yes";
  };
}
