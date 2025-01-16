{ outputs, ... }:

{
  imports = [
    ./secrets

    outputs.homeModules.common
    outputs.homeModules.nixvim
    outputs.homeModules.sops
  ];

  home.username = "susagi";

  programs.git = {
    enable = true;
    userName = "susagi";
    userEmail = "susagi@sid.ovh";
  };

  programs.nixvim = {
    enable = true;
  };

  programs.fastfetch = {
    enable = true;
  };

  home.stateVersion = "24.11";

  # nix.extraOptions = ''
  #   !include ${config.sops.templates.access-tokens.path}
  # '';
}
