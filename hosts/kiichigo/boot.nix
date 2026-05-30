{lib, ...}: {
  boot = {
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };
  };
  systemd.tpm2.enable = lib.mkForce false;
  security.tpm2.enable = lib.mkForce false;
}
