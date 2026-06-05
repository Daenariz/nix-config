{
  boot.loader.grub = {
    enable = true;
    devices = [ "nodev" ];
    efiSupport = true;
    useOSProber = true;
    configurationLimit = 20;
  };
  boot.loader.efi.canTouchEfiVariables = true;
}
