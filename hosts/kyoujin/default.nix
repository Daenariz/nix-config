{
  lib,
  config,
  inputs,
  outputs,
  pkgs,
  ...
}:
{
  imports = [
    inputs.synix.nixosModules.normalUsers
    #    ./wyoming.nix
    ./boot.nix
    ./hardware.nix
    ./networking.nix
    ./packages.nix
    #    ./services.nix
    ./ollama.nix
    ./secrets
    inputs.synix.nixosModules.common
    #     inputs.synix.nixosModules.sops
    inputs.synix.nixosModules.nvidia
    inputs.synix.nixosModules.openssh

    outputs.nixosModules.common
  ];

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "cuda_cudart"
      "cuda_nvcc"
      "cuda_cccl"
      "libcublas"
      "cuda-merged"
      "cuda_cuobjdump"
      "cuda_gdb"
      "cuda_nvdisasm"
      "cuda_nvprune"
      "cuda_cupti"
      "cuda_cuxxfilt"
      "cuda_nvml_dev"
      "cuda_nvrtc"
      "cuda_nvtx"
      "cuda_profiler_api"
      "cuda_sanitizer_api"
      "libcufft"
      "libcurand"
      "libcusolver"
      "libnvjitlink"
      "libcusparse"
      "libnpp"
      "nvidia-settings"
    ];

  services.tailscale.enable = true;

  #
  nix.settings.trusted-substituters = [ "https://ai.cachix.org" ];
  nix.settings.trusted-public-keys = [
    "ai.cachix.org-1:N9dzRK+alWwoKXQlnn0H6aUx0lU/mspIoz8hMvGvbbc="
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
