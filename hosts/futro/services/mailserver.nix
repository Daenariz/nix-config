{
  inputs,
  config,
  lib,
  ...
}:
{
  imports = [
    inputs.synix.nixosModules.mailserver
  ];

  mailserver = {
    enable = true;
    subdomain = "mail";
    stateVersion = 3;
    # TLS certs from previous ACME run; edge handles ACME renewal going forward
    x509 = {
      useACMEHost = lib.mkForce null;
      certificateFile = "/var/lib/acme/mail.negitorodon.de/fullchain.pem";
      privateKeyFile = "/var/lib/acme/mail.negitorodon.de/key.pem";
    };
    accounts'.susagi.aliases = [ "postmaster" ];
  };
}
