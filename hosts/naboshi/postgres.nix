{ config, pkgs, lib, ...
}:

{
  services.postgresql = {
    enable = true;
    ensureDatabases = [ "test1" ];
    authentication = pkgs.lib.mkOverride 10 ''
      #type database DBuser auth-method
      local all      all    trust
      '';
      
    };
    
}
