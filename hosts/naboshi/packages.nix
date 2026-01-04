{ pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
    local.riichi-city
    ];
  };
}
