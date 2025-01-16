{
  inputs,
  lib,
  pkgs,
  ...
}:

{
  programs = {
    # opacity setting for kitty
    kitty.settings.background_opacity = lib.mkForce "0.5";

    # transparent nixvim plugin, only works with styling.scheme disabled since background color might be overwritten I guess
    nixvim.plugins.transparent.enable = lib.mkForce false;

    librewolf.profiles.default.extensions = lib.mkAfter (
      with inputs.nur.legacyPackages."${pkgs.system}".repos.rycee.firefox-addons;
      [
        bitwarden
      ]
    );
    ssh.addKeysToAgent = "confirm";
  };
}
