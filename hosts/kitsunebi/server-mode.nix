{ lib,...}:
{
specialisation."server-mode".configuration = {
    # Ein Tag im Boot-Menü, damit du erkennst, was du bootest
    system.nixos.tags = [ "server-mode" ];

    # 1. Desktop-Umgebung deaktivieren
    programs.hyprland.enable = lib.mkForce false;
    services.xserver.enable = lib.mkForce false; # Falls du X11/SDDM/GDM nutzt
    services.displayManager.sddm.enable = lib.mkForce false; 

    # 2. Server-Dienste explizit nur hier aktivieren (optional)
    # services.ollama.enable = true;

    # 3. Optional: Konsolen-Login statt Grafik-Login erzwingen
    services.getty.autologinUser = "neo"; 
  };
}
