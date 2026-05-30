{
  config,
  pkgs,
  lib,
  ...
}: {
  specialisation."gamemode".configuration = {
    system.nixos.tags = ["gamemode"];

    environment.variables.IS_HEADLESS = lib.mkForce "";

    programs.hyprland.enable = true;

    #    security.rtkit.enable = true;
    services.pipewire = {
      enable = true;
      #     alsa.enable = true;
      #     pulse.enable = true;
    };

    #  services.displayManager.sddm.enable = true;
    #  services.xserver.enable = true; # X11-Unterbau auch für Wayland oft nötig für SDDM

    # 4. CUDA/Ollama Optimierungen für Desktop (optional)
    # services.ollama.enable = lib.mkForce false;
  };
}
