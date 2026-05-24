{ inputs, lib, config, ... }:
{
  imports = [
    inputs.synix.nixosModules.tailscale
  ];

 services.tailscale = {
    enable = true;
    tailnets = {
      personal = {
        loginServer = "https://head.negitorodon.de";
        authKeyFile = config.sops.secrets."tailscale/auth-key".path;
        enableSSH = true;
        };
      };
  };

  networking = {
    #    wireless.enable = lib.mkForce true;
    hostName = "naboshi";
    firewall = {
      checkReversePath = "loose";
      trustedInterfaces = [ "tailscale0" ];
      allowedUDPPorts = [ 24727 ];
      allowedTCPPorts = [
        8123
        # 36497
        # 6667
      ];
    };
  };
}
