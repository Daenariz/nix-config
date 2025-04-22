{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    nixfmt
    raspberrypi-eeprom
  ];
}
