{
  programs.mangohud = {
    enable = true;
    enableSessionWide = true;
    settings = {
      gamemode = true;
      output_folder = "${config.home.homeDirectory}/Documents/mangologs";
    }; # https://github.com/flightlessmango/MangoHud/blob/master/data/MangoHud.conf
  };
}
