{
  boot = {
    loader = {
      grub.enable = false;
      generic-extlinux-compatible.enable = true;
    };

    swraid = {
      enable = true;
      mdadmConf = "
      ARRAY /dev/md/0 metadata=1.2 UUID=ee67e001:209d433a:b1e0f1f7:6c3b5d77
      ";
    };
  };
}
