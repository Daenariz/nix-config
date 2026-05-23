{
  boot = {
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };

  };
  systemd.tpm2.enable = false;
}
