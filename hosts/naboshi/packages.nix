{ pkgs, lib, ... }:

{

  #     nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
  # "steam"
  # "steam-unwrapped"
  #            ];

  environment = {
    systemPackages = with pkgs; [
      local.riichi-city
    ];
  };
}
