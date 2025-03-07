{
  disko = import ../../disko/simple-efi.nix {
    device = "/dev/sda";
    swap = true;
    swapGB = 8;
  };
}
