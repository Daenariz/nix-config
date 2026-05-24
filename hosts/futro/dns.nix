{ inputs, config, pkgs, ... }:

{
  imports = [ "${inputs.hetzner_ddns}/release/NixOS/nixos_module.nix" ];
  sops.secrets.hetzner_api_key = {
    group = "keys";
    mode = "0440";
  };

  services.hetzner_ddns = {
    enable = true;
    
    # Verwende api_key_file, um den Pfad aus sops zu übergeben [1]
    api_key_file = config.sops.secrets.hetzner_api_key.path;

    # minimal zone config
    zones = [
      {
        domain = "kokushi-musou.de";
        records = [
          {
            name = "@";     # maindomain
            type = "A";
          }
        ];
      }
    ];
  };
  systemd.services.hetzner_ddns = {
  serviceConfig = {
    # Fügt den dynamischen User der Gruppe 'keys' hinzu
    SupplementaryGroups = [ "keys" ];
  };
};
}
