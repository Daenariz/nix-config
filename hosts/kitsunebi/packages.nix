{
  lib,
  config,
  pkgs,
  ...
}:

let
  nvidia-pkg = config.hardware.nvidia.package;
in
{
  environment = {
    systemPackages = with pkgs; [
    ];
  };

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable; # Same as production
    nvidiaSettings = true;
    # enable the open source drivers if the package supports it
    open = lib.mkOverride 990 (nvidia-pkg ? open && nvidia-pkg ? firmware);
    modesetting.enable = true;
  };

  hardware.graphics = {
    enable = true;
    extraPackages = [
      pkgs.nvidia-vaapi-driver
    ];
  };

  services.xserver.videoDrivers = [ "nvidia" ]; # only works with hardware.nvidia.open
}
