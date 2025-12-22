{ pkgs, lib, ... }:

{
  boot = {
    kernelPackages = pkgs.linuxKernel.packages.linux_rpi4;
    initrd.availableKernelModules = [
      "xhci_pci"
      "usbhid"
      "usb_storage"
    ];
  };

  fileSystems = {
    "/" = {
      device = "/dev/disk/by-label/NIXOS_SD";
      fsType = "ext4";
      options = [ "noatime" ];
    };
    # "/data" = {
    #   device = "/dev/md0";
    #   fsType = "ext4";
    # };
  };

  nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
  hardware.enableRedistributableFirmware = true;
  # system.stateVersion = "24.11";
}
