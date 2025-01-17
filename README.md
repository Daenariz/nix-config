# NixOS and Home Manager configurations

This repository is a collection of personal NixOS configurations with standalone Home Manager powered by [nix-core](https://github.com/sid115/nix-core).

## Directory Structure

```
.
├── flake.lock            # Lock file for the Nix Flakes configuration
├── flake.nix             # Nix Flake file for the configuration
├── hosts                 
│   ├── kiichigo          # Raspberry 4 config
│   ├── naboshi           # Workstation config
│   └── shizen            # Teststation config
├── modules               
│   ├── home              # Home-specific modules
│   └── nixos             # NixOS-specific modules
├── overlays              
├── pkgs                  # Custom Nix packages
├── README.md             
├── shell.nix             # Shell configuration for NixOS development environment
└── users                 
    └── susagi            # Susagis user
        ├── home          # Home-specific configurations
        ├── hyprland      # Hyprland-specific configurations
        └── pubkeys       # Public keys
```
