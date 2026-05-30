{
  lib,
  pkgs,
  ...
}: {
  # # fix CVE-2026-31431
  # boot.kernelPackages = lib.mkIf (lib.versionOlder pkgs.linux.version "6.18.22") (
  #   lib.mkDefault pkgs.linuxPackages_6_18
  # );
}
