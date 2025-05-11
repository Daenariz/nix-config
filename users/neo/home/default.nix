{ inputs, outputs, ... }:

{
  imports = [
    inputs.core.homeModules.common
    inputs.core.homeModules.nixvim

    outputs.nixosModules.common
  ];

  home.username = "neo";

  programs.git = {
    enable = true;
    userName = "Daenariz";
    userEmail = "deniz.onlinegames@gmail.com";
  };

  home.file.nixpkgs_config = {
    target = ".config/nixpkgs/config.nix";
    text = ''
      {allowUnfree = true; }
    '';
  };

  programs.nixvim.enable = true;

  home.stateVersion = "24.11";
}
