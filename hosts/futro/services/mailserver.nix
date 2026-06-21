{ inputs, config, ... }:
{
  imports = [
    inputs.synix.nixosModules.mailserver
  ];

  mailserver.enable = true;
  mailserver.stateVersion = 3;
  mailserver.accounts.susagi.aliases = [ "postmaster@${config.networking.domain}" ];
}
