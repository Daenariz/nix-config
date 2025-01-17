### NixOS and Home Manager configurations

This repository is a collection of personal NixOS configurations with standalone Home Manager powered by [nix-core](https://github.com/sid115/nix-core).

## Directory Structure

´´´
.
├── flake.lock            # Lock file for the Nix Flakes configuration
├── flake.nix             # Nix Flake file for the configuration
├── hosts                 # Host-specific configurations
│   ├── kiichigo
│   ├── naboshi
│   └── shizen
├── modules               # Reusable modules and functions
│   ├── home              # Home-specific modules
│   └── nixos             # NixOS-specific modules
├── overlays              # Nix Overlays
├── pkgs                  # Custom Nix packages
├── README.md             # This file
├── shell.nix             # Shell configuration for NixOS development environment
└── users                 # User-specific configurations
    └── susagi            # Example user
        ├── home          # Home-specific configurations
        ├── hyprland      # Hyprland-specific configurations
        └── pubkeys       # Public keys
´´´
