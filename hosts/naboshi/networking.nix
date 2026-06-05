{
  inputs,
  lib,
  config,
  ...
}: {
  imports = [
  ];

  services.tailscale.enable = true;

  networking = {
    #    wireless.enable = lib.mkForce true;
    hostName = "naboshi";
    firewall = {
      checkReversePath = "loose";
      trustedInterfaces = ["tailscale0"];
      allowedUDPPorts = [24727];
      allowedTCPPorts = [
        8123
        # 36497
        # 6667
      ];
    };
  };
}
