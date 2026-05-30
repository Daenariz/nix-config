{
  config,
  pkgs,
  ...
}: {
  programs.obs-studio = {
    enable = true;
    package = (
      pkgs.obs-studio.override {
        cudaSupport = true;
      }
    );
    plugins = with pkgs.obs-studio-plugins; [
      advanced-scene-switcher
      wlrobs
    ];
  };

  home.packages = [pkgs.obs-cmd];

  systemd.user.services.obs = {
    Unit = {
      Description = "OBS Studio Replay Buffer";
      PartOf = ["graphical-session.target"];
    };
    Service = {
      ExecStart = "${config.programs.obs-studio.finalPackage}/bin/obs --startreplaybuffer --minimize-to-tray";

      ExecStop = "${pkgs.obs-cmd}/bin/obs-cmd replay stop";

      TimeoutStopSec = "15s";

      KillSignal = "SIGINT";

      Restart = "on-failure";
    };
    Install = {
      WantedBy = ["graphical-session.target"];
    };
  };
}
