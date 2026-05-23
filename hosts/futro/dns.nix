{ config, pkgs, ... }:

{
  # Sops-Konfiguration für den API-Key
  sops.secrets.hetzner_api_key = {
    # Optional: Besitzer des Secrets auf den DynamicUser des Services anpassen, 
    # falls Berechtigungsprobleme auftreten. Meist reicht Standard.
    owner = "root"; 
  };

  services.hetzner_ddns = {
    enable = true;
    
    # Verwende api_key_file, um den Pfad aus sops zu übergeben [1]
    api_key_file = config.sops.secrets.hetzner_api_key.path;

    # Minimale Zonen-Konfiguration
    zones = [
      {
        domain = "kokushi-musou.de";
        records = [
          {
            name = "@";     # Hauptdomain
            type = "A";     # Standard ist A, hier explizit zur Klarheit [1]
          }
          {
            name = "www";   # Subdomain
            type = "A";
          }
        ];
      }
    ];
  };
}
