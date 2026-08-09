{
  lib,
  pkgs,
  inputs,
  outputs,
  ...
}:
let
  inherit (lib) mkForce mkAfter;
in
{
  imports = [
    inputs.synix.homeModules.librewolf
    ./mangohud.nix
    # ./obs-studio.nix
    # ./vesktop.nix
  ];

  programs = {
    btop.enable = true;

    librewolf = {
      enable = true;
      searchEngines = [
        "howlongtobeat"
        "keyforsteam"
        "protondb"
        "steamdb"
      ];
      profiles.default = {
        extensions.packages = mkAfter (
          with inputs.nur.legacyPackages."${pkgs.system}".repos.rycee.firefox-addons;
          [
            bitwarden
            yomitan
          ]
        );
      };
    };

    kitty.settings.background_opacity = mkForce "0.3";
    # transparent nixvim plugin, only works with styling.scheme disabled since background color might be overwritten I guess
    nixvim.plugins.transparent.enable = mkForce true;
  };
}
