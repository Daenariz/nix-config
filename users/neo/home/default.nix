{ inputs, outputs, ... }:

{
  imports = [
    inputs.core.homeModules.common
    inputs.core.homeModules.nixvim

    outputs.homeModules.common
  ];

  home.username = "neo";

  programs.git = {
    enable = true;
    settings = {
    user.name = "Daenariz";
    user.email = "deniz.onlinegames@gmail.com";
  };
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
