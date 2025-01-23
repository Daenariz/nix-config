{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nvim
    nixfmt
  ];
}
