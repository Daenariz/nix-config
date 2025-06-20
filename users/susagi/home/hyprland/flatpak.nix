{ inputs, ... }:
{
  imports = [
    inputs.nix-flatpak.homeManagerModules.nix-flatpak
  ];
  services.flatpak = {
    enable = true;
    update = {
      onActivation = false;
      auto = {
        enable = true;
        onCalendar = "weekly";
      };
    };
    packages = [
      {
        appId = "us.zoom.Zoom";
        origin = "flathub";
      }
    ];
  };
}
