{ outputs, ... }:

{
  nixpkgs.overlays = [
    outputs.overlays.core-dev-packages
    outputs.overlays.core-packages
    outputs.overlays.local-packages
    outputs.overlays.modifications
    outputs.overlays.old-stable-packages
    outputs.overlays.old-old-stable-packages
    outputs.overlays.stable-packages
  ];
}
