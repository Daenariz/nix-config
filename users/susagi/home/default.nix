{ inputs, outputs, config, pkgs, ... }:

{
  imports = [
    ./secrets

    inputs.core.homeModules.common
    inputs.core.homeModules.nixvim
    inputs.core.homeModules.sops

    outputs.homeModules.common
  ];

  home.username = "susagi";

  programs.git = {
    enable = true;
    userName = "susagi";
    userEmail = "susagi@sid.ovh";
  };

  # xdg might not be available, hence `home.file`
  home.file.nixpkgs_config = {
    target = ".config/nixpkgs/config.nix";
    text = ''
      { allowUnfree = true; }
    '';
  };

  programs = {
    nixvim.enable = true;
    fastfetch.enable = true;
  };

  nix.package = pkgs.nix;
  nix.extraOptions = ''
    !include ${config.sops.templates.access-tokens.path}
    '';

  home.stateVersion = "24.11";
}
