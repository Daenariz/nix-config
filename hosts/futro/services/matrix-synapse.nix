{
  inputs,
  config,
  lib,
  ...
}:
{
  imports = [
    inputs.synix.nixosModules.matrix-synapse
  ];

  nixpkgs.config.permittedInsecurePackages = [
    "olm-3.2.16"
  ];

  services.matrix-synapse = {
    enable = true;
    sops = true;
    # dataDir = "/data/matrix-synapse";
    coturn.enable = true;
    bridges = {
      whatsapp = {
        enable = true;
        admin = "@susagi:${config.networking.domain}";
      };
      signal = {
        enable = true;
        admin = "@susagi:${config.networking.domain}";
      };
    };
  };

  # TLS terminated on edge
  services.nginx.virtualHosts."${config.networking.domain}" = {
    enableACME = lib.mkForce false;
    forceSSL = lib.mkForce false;
    listen = lib.mkForce [
      {
        addr = "100.64.0.3";
        port = 80;
      }
    ];
  };

  # TODO: nix-core: toggle user if coturn and synapse are not running on the same machine
  sops.secrets."coturn/static-auth-secret" = {
    owner = lib.mkForce "matrix-synapse";
    group = lib.mkForce "matrix-synapse";
  };
}
