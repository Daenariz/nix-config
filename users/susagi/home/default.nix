{
  inputs,
  outputs,
  config,
  pkgs,
  ...
}: {
  imports = [
    ./secrets

    inputs.synix.homeModules.common
    inputs.synix.homeModules.nixvim
    inputs.synix.homeModules.sops

    outputs.homeModules.common
    # outputs.homeModules.nextcloud-sync
  ];

  home.username = "susagi";

  programs.git = {
    enable = true;
    settings = {
      user.name = "Daenariz";
      user.email = "dev@deniz-eckert.de";
    };
  };

  # xdg might not be available, hence `home.file`
  home.file.nixpkgs_config = {
    target = ".config/nixpkgs/config.nix";
    text = ''
      { allowUnfree = true; }
    '';
  };

  programs = {
    nixvim = {
      enable = true;
      plugins.copilot-lua.settings = {
        filetypes = {
          markdown = true;
        };
      };
    };
    #nixvim.enable = true;
    fastfetch.enable = true;
  };

  nix.package = pkgs.nix;
  nix.extraOptions = ''
    !include ${config.sops.templates.access-tokens.path}
  '';

  # If tokens got updated, remove old ones:
  # sudo rm -f /home/susagi/.config/sops-nix/secrets/rendered/access-tokens
  sops.templates.access-tokens.content = ''
    access-tokens = github.com=${config.sops.placeholder.github-token}
  '';

  home.stateVersion = "24.11";
}
