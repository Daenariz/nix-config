{
  inputs,
  outputs,
  pkgs,
  config,
  ...
}:

{
  imports = [
    inputs.core.nixosModules.common
    inputs.core.nixosModules.device.laptop
    inputs.core.nixosModules.normalUsers
    inputs.core.nixosModules.hyprland
    inputs.core.nixosModules.openssh
    inputs.core.nixosModules.tailscale
    # inputs.core.nixosModules.sops
    # inputs.core.nixosModules.virtualisation
    #     outputs.nixosModules.postgresql

    outputs.nixosModules.common

    ./boot.nix
    ./hardware.nix
    ./postgres.nix
    ./packages.nix

    ./secrets
  ];

  virtualisation.vmware.host.enable = true;


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
  services.tailscale = {
    enable = true;
    enableSSH = true;
    loginServer = "https://head.negitorodon.de";
    # loginServer = "head.${config.networking.domain}";
  };

  # programs.dconf.enable = true;

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

  networking = {
    hostName = "naboshi";
    firewall.allowedUDPPorts = [ 24727 ];
    firewall.allowedTCPPorts = [
      8123
      # 36497
      # 6667
    ];
  };

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
