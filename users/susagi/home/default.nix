{ inputs, outputs, ... }:

{
  imports = [
    inputs.core.homeModules.common
    inputs.core.homeModules.nixvim

    outputs.nixosModules.common
  ];

  home.username = "susagi";

  programs.git = {
    enable = true;
    userName = "susagi";
    userEmail = "susagi@sid.ovh";
  };

  programs.nixvim.enable = true;

  home.stateVersion = "24.11";
}
