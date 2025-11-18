{
  pkgs,
  lib,
  ...
}:

{
  services.postgresql = {
    enable = true;
    #        ensureDatabases = [ "test1" ];
    package = pkgs.postgresql_16;
    #    enableTCPIP = true;
    settings.port = 5432;
    authentication = pkgs.lib.mkOverride 10 ''
      #type database DBuser auth-method
      local all      all    trust
       # Vorhandene Regel für lokale Socket-Verbindungen (für sudo -u postgres psql)
    local   all         all                 peer

    # NEUE REGELN für Netzwerkverbindungen von localhost (für pgAdmin & Co.)
    # Diese Zeile erlaubt unverschlüsselte Verbindungen von 127.0.0.1 (IPv4)
    host    all         all     127.0.0.1/32  md5
    # Diese Zeile erlaubt unverschlüsselte Verbindungen von ::1 (IPv6)
    host    all         all     ::1/128       md5

    # Falls du nur verschlüsselte Verbindungen erlauben willst (bessere Sicherheit):
    # hostssl all         all     127.0.0.1/32  md5
    # hostssl all         all     ::1/128       md5
    '';
  };

  services.pgadmin = {
    enable = true;
    initialEmail = "susagi@negitorodon.de";
    initialPasswordFile = "/home/susagi/pgpass";
    settings = {
      "MAX_LOGIN_ATTEMPTS" = 0;
    };
  };
}
