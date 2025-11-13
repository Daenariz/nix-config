{
  inputs,
  outputs,
  config,
  ...
}:

{
  imports = [
    inputs.core.nixosModules.common
    inputs.core.nixosModules.nginx
    inputs.core.nixosModules.normalUsers
    inputs.core.nixosModules.openssh
    inputs.core.nixosModules.open-webui
    inputs.core.nixosModules.vaultwarden
    inputs.core.nixosModules.mailserver
    #    inputs.core.nixosModules.matrix-synapse

    ./secrets

    outputs.nixosModules.common

    ./boot.nix
    ./hardware.nix # will be generated during installation
    ./packages.nix
  ];

  networking = {
    domain = "negitorodon.de";
    hostName = "futro";
    interfaces.enp1s0.wakeOnLan = {
      enable = true;
      policy = [
        "magic"
      ];
    };
  };

  mailserver = {
    enable = true;
    stateVersion = 3;
    loginAccounts = {
      "susagi@${config.networking.domain}" = {
        hashedPasswordFile = config.sops.secrets."mailserver/accounts/susagi".path;
        aliases = [ "postmaster@${config.networking.domain}" ];
      };
    };
  };

  #  services.matrix-synapse = {
  #    enable = true;
  #     dataDir = "/data/matrix-synapse";
  #    bridges = {
  #  whatsapp.enable = true;
  #  whatsapp.admin = "@susagi:${config.networking.domain}";
  #      signal.enable = true;
  #      signal.admin = "@susagi:${config.networking.domain}";
  # };
  #};
  #mailserver.enable = false;

  services.vaultwarden.enable = true;
  services.vaultwarden.subdomain = "vault";

  services.open-webui = {
    enable = true;
    #  openFirewall = true;
    #    host = "0.0.0.0";
  };

  services = {
    nginx.enable = true;
    openssh = {
      enable = true;
      ports = [
        30715
      ];
    };
  };

  programs.ssh.startAgent = true;

  normalUsers = {
    susagi = {
      extraGroups = [
        "wheel"
      ];
      sshKeyFiles = [
        ../../users/susagi/pubkeys/vde_rsa.pub
        ../../users/susagi/pubkeys/futro_rsa.pub
        ../../users/susagi/pubkeys/kyojin_rsa.pub
      ];
    };
  };
  system.stateVersion = "24.11";
}
