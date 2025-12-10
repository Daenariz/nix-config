{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nixfmt
    git
    #    raspberrypi-eeprom
  ];
}
