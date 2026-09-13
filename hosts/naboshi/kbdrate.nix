{ pkgs, ... }: {
  # Adjusts repeat rate of keyboard in tty 
  systemd.services.tty-kbdrate = {
    description = "setting TTY keyboard delay and rate";
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      # -d 500: increases input delay to 500 ms (default is 250)
      # -r 10.0: sets the repeat rate to 10 letters per second (slower)
      ExecStart = "${pkgs.kbd}/bin/kbdrate -d 500 -r 10.0";
    };
  };
}
