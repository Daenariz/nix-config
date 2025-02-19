{ config, lib, ... }:

{
  # Japanische Eingabemethode mit IBus/Mozc
  i18n.inputMethod = {
    enabled = "ibus";
    ibus.engines = with pkgs; [ ibus-engines.mozc ];
  };

  # Tastatur-Layout-Switching mit Super+Leertaste
  services.xserver = {
    layout = "us,de";
    xkbOptions = "grp:win_space_toggle";
  };
}
