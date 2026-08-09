{
  inputs,
  outputs,
lib,
  ...
}:
{
  imports = [
    inputs.synix.homeModules.common
    inputs.synix.homeModules.nixvim

    outputs.homeModules.common

    ./programs.nix
    ./packages.nix
    ./obs-studio.nix
    ./mangohud.nix


  ];

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "castlabs-electron"
      "zoom"
      "steam"
      "steam-unwrapped"
      "discord"
      "transparent.nvim"
    ];

  home.username = "neo";

  programs.git = {
    enable = true;
    settings = {
      user.name = "Daenariz";
      user.email = "dev@deniz-eckert.de";
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
