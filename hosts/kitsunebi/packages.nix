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
      gnomeExtensions.pop-shell
      gnome-tweaks
      nautilus
      element-desktop
    ];
  };
  # nixpkgs.config.android_sdk.accept_license = true;

  nixpkgs.config.allowUnfreePredicate =
    pkg:
    builtins.elem (lib.getName pkg) [
      "nvidia-x11"
      "cuda_cudart"
      "cuda_cccl"
      "cuda_nvcc"
      "libcublas"
      "steam"
      "steam-unwrapped"
      "nvidia-settings"
    ];

  hardware.nvidia = {
    package = config.boot.kernelPackages.nvidiaPackages.stable; # Same as production
    nvidiaSettings = true;
    # enable the open source drivers if the package supports it
    open = lib.mkOverride 990 (nvidia-pkg ? open && nvidia-pkg ? firmware);
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;
  };

  hardware.graphics = {
    enable = true;
    extraPackages = [
      pkgs.nvidia-vaapi-driver
    ];
  };

  services.xserver.videoDrivers = [ "nvidia" ]; # only works with hardware.nvidia.open
}
