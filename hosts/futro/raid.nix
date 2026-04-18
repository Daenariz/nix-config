{ pkgs, config, ... }:
{
  services.smartd = {
    enable = true;

    defaults.autodetected = ''
      -a -o on -S on -n standby,q -s (S/../.././02|L/../../6/03) -W 4,50,60 -m root -M exec ${pkgs.writeShellScript "smartd-ntfy.sh" ''
        TOPIC=$(${pkgs.coreutils}/bin/cat ${config.sops.secrets.ntfy_topic.path})

        ${pkgs.curl}/bin/curl \
          -H "Title: 🚨 Server-Alarm: $SMARTD_DEVICE" \
          -H "Tags: warning,rotating_light,hdd" \
          -H "Priority: high" \
          -d "SMARTD meldet ein Problem: $SMARTD_MESSAGE" \
          "https://ntfy.sh/$TOPIC"
      ''} 
    '';
  };
}
