{
  pkgs,
  lib,
  ...
}:

{
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "test1" ];
    package = pkgs.postgresql_16;
    enableTCPIP = true;
    settings.port = 5432;
    authentication = pkgs.lib.mkOverride 10 ''
      #type database DBuser auth-method
      local all      all    trust
    '';
  };

  services.pgadmin = {
    enable = true;
    initialEmail = "susagi@negitorodon.de";
    initialPasswordFile = "/home/susagi/pgpass";
  };
}
