{ inputs, ... }:
{
  imports = [
    inputs.core.nixosModules.tailscale
  ];
  services.tailscale = {
    enable = true;
    enableSSH = true;
    loginServer = "https://head.negitorodon.de";
  };

  networking = {
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
