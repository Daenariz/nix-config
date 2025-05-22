{
  services = {
    hyprpaper = {
      enable = true;
      settings = {
        preload = [ "~/Pictures/wallpaper.jpg" ];
        wallpaper =  [ ",~/Pictures/wallpaper.jpg" ];
      };
    };

    hypridle = {
      enable = true;
      settings = import ./settings/hypridle.nix;
    };

    hyprsunset = {
      enable = true;
      transitions = {
        sunrise = {
          calendar = "*-*-* 06:00:00";
          requests = [
            [
              "temperature"
              "5000"
            ]
            [ "gamma 100" ]
          ];
        };
        sunset = {
          calendar = "*-*-* 19:00:00";
          requests = [
            [
              "temperature"
              "3500"
            ]
          ];
        };
      };
    };
  };
}
