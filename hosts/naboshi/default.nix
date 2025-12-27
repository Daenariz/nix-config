{
  inputs,
  outputs,
  pkgs,
  config,
  lib,
  ...
}:

{
  imports = [
    inputs.core.nixosModules.common
    inputs.core.nixosModules.device.laptop
    inputs.core.nixosModules.normalUsers
    inputs.core.nixosModules.hyprland
    inputs.core.nixosModules.openssh
    # inputs.core.nixosModules.sops
    # inputs.core.nixosModules.virtualisation
    #     outputs.nixosModules.postgresql

    outputs.nixosModules.common

    ./boot.nix
    ./hardware.nix
    ./postgres.nix
    ./packages.nix
    ./networking.nix

    ./secrets
  ];

  programs.steam = {
    enable = true;
    remotePlay.openFirewall = true;
    dedicatedServer.openFirewall = false;
    localNetworkGameTransfers.openFirewall = true;
    gamescopeSession.enable = true;
  };

  # virtualisation.libvirtd.qemu.runAsRoot = true;
  #   virtualisation.libvirtd.qemu.verbatimConfig = lib.mkForce ''
  #               clear_emulation_capabilities = 1
  # '';
  #   virtualisation.libvirtd.deviceACL = [
  # "/dev/null" "null"
  #           "/dev/full" "full"
  #           "/dev/zero" "zero"
  #           "/dev/random" "random"
  #           "/dev/urandom" "urandom"
  #           "/dev/ptmx" "ptmx"
  #           "/dev/kvm" "kvm"
  #           "/dev/rtc" "rtc"
  #           "/dev/hpet" "hpet"  ];
  #   # #   # virtualisation.vmware.host.enable = true;
  #   # #
  #   users.extraGroups.libvirtd.members = [ "susagi" ];
  #   users.extraGroups.qemu-libvirtd.members = [ "susagi" ];
  #   users.extraGroups.kvm.members = [ "susagi" ];
  #

  #   services.ngircd.enable = true;
  #   services.ngircd.config = ''
  #   [Global]
  #   Name = irc.negi.jp
  #   AdminInfo1 = Negi IRC Server
  #   AdminInfo2 = Anywhere On Asu
  #   AdminEMail = admin@irc.negi.jp
  #
  #   [Operator]
  #   Name = TheOper
  #   Password = Hans1234
  #   ''
  # ;

  programs.dconf.enable = true;

  boot.binfmt.emulatedSystems = [
    "aarch64-linux"
  ];

  services.xserver.xkb.layout = "de";

  #  services.displayManager.sddm = {
  #  enable = true;
  #  wayland.enable = true;
  #    settings = {
  #};
  #};

  services = {
    udev.packages = with pkgs; [
      platformio-core.udev
    ];
    openssh.enable = true;
    pipewire.enable = true;
    flatpak.enable = true;
  };

  programs.hyprland.enable = true;

  normalUsers = {
    susagi = {
      extraGroups = [
        "input"
        "audio"
        "floppy"
        "lp"
        "networkmanager"
        "video"
        "wheel"
        "dialout"
        "libvirtd"
        "kvm"
        "qemu-libvirtd"
        "disk"
      ];
    };
  };

  system.stateVersion = "24.11";
}
