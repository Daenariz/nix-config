{ inputs, outputs, pkgs, ... }:

{
  imports = [
    inputs.core.nixosModules.normalUsers
    #    ./wyoming.nix
    ./boot.nix
    ./hardware.nix
    ./networking.nix
    ./packages.nix
    #    ./services.nix
    #./ollama.nix
    inputs.core.nixosModules.common
    inputs.core.nixosModules.sops
    inputs.core.nixosModules.nvidia
    inputs.core.nixosModules.openssh

    outputs.nixosModules.common

  ];

  normalUsers = {
    susagi = {
      extraGroups = [ "wheel" ];
      sshKeyFiles = [
        ../../users/susagi/pubkeys/vde_rsa.pub
        ../../users/susagi/pubkeys/id_rsa.pub
        ../../users/susagi/pubkeys/tab.pub
        ../../users/susagi/pubkeys/w10_rsa.pub
        ../../users/neo/kitsunebi_rsa.pub
      ];
    };
  };

  networking = {
    interfaces.enp8s0.wakeOnLan = {
      enable = true;
      policy = [
        "magic"
      ];
    };
  };

  systemd.services.wakeonlan = {
    description = "Reenable wake on lan every boot";
    after = [ "network.target" ];
    serviceConfig = {
      Type = "simple";
      RemainAfterExit = "true";
      ExecStart = "${pkgs.ethtool}/sbin/ethtool -s enp8s0 wol g";
    };
    wantedBy = [ "default.target" ];
  };


systemd.timers.shutdownAtMidnight = {
  wantedBy = [ "timers.target" ];
  timerConfig = {
    OnCalendar = "daily";
    Persistent = true;
  };
};

systemd.services.shutdownAtMidnight = {
  serviceConfig.Type = "oneshot";
  script = "/run/current-system/sw/bin/shutdown -h now";
};

  programs.ssh.startAgent = true;

  services.openssh = {
    enable = true;
    ports = [ 2299 ];
  };
  system.stateVersion = "24.11";

}
