{ inputs, outputs, ... }:

{
  imports = [
    inputs.core.homeModules.common
    inputs.core.homeModules.nixvim

    outputs.nixosModules.common
  ];

  home.username = "USERNAME";

  programs.git = {
    enable = true;
    userName = "Daenariz";
    userEmail = "deniz.onlinegames@gmail.com";
  };

  programs.nixvim.enable = true;

  home.stateVersion = "24.11";
}
