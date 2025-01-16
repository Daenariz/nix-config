{ inputs, outputs, ... }:

{
  imports = [
    ./secrets

    inputs.core.homeModules.common
    inputs.core.homeModules.nixvim
    # inputs.core.homeModules.sops

    #outputs.homeModules.sops
    #outputs.nixosModules.common
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
