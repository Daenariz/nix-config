{ outputs, ... }:

{
  nixpkgs.overlays = [
    #    outputs.overlays.synix-dev-packages
    outputs.overlays.synix-packages
    outputs.overlays.local-packages
    outputs.overlays.modifications
    outputs.overlays.old-stable-packages
    outputs.overlays.old-old-stable-packages
    outputs.overlays.stable-packages
  ];
}
