{ config, pkgs, ... }:

{
  environment = {
    systemPackages = with pkgs; [
      mangohud
      protonup-qt
      lutris
      bottles
      heroic
    ];
  };

  hardware.nvidia = {
    nvidiaSettings = true;
    open = false;
    modesetting.enable = true;
    prime = {
      offload = {
        # sync doesn't seem to be supported on older gpus
        enable = true;
        enableOffloadCmd = true;
      };
      intelBusId = "PCI:00:02:0";
      nvidiaBusId = "PCI:01:00:0";
    };
    package = config.boot.kernelPackages.nvidiaPackages.stable; # Same as production
  };

  hardware.graphics.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ]; # only works with hardware.nvidia.open
}
