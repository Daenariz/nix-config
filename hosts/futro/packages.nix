{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [ mdadm wol ];
}
