{
  services = {
    hyprpaper = {
      enable = true;
      settings = {
        preload = [ "~/Pictures/wallpaper.jpg" ];
        wallpaper = [ ",~/Pictures/wallpaper.jpg" ];
      };
    };

    hypridle = {
      enable = true;
      settings = import ./settings/hypridle.nix;
    };

    hyprsunset = {
      enable = true;
      settings = {
        sunrise = {
          time = "6:00";
          temperature = 5000;
        };
        sunset = {
          time = "19:00";
          temperature = 3500;
        };
      };
    };
  };
}
