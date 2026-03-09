
{ pkgs, ...}:
{
# X11 Window-System aktivieren (wird für GNOME benötigt)
  services.xserver.enable = true;

  # GNOME Desktop Manager und Desktop Environment aktivieren
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  environment.systemPackages = with pkgs; [
  gnomeExtensions.forge  # Sehr gutes Tiling-System für GNOME
  # oder gnomeExtensions.pop-shell
];
}
