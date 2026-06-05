{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    synix = {
      url = "git+https://git.sid.ovh/sid/synix.git?ref=develop";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    sops-nix = {
      url = "github:mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    riichi-club = {
      url = "github:Daenariz/riichi-club";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    hetzner_ddns = {
      url = "github:filiparag/hetzner_ddns";
    };
  };

  outputs = {
    self,
    nixpkgs,
    home-manager,
    ...
  } @ inputs: let
    inherit (self) outputs;
    supportedSystems = [
      "x86_64-linux"
      "aarch64-linux"
    ];
    forAllSystems = nixpkgs.lib.genAttrs supportedSystems;

    lib = nixpkgs.lib.extend (final: prev: inputs.synix.lib or {});

    mkNixosConfiguration = system: modules:
      nixpkgs.lib.nixosSystem {
        inherit system modules;
        specialArgs = {
          inherit inputs outputs lib;
        };
      };
  in {
    formatter = forAllSystems (system: nixpkgs.legacyPackages.${system}.alejandra);

    packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

    overlays = import ./overlays {inherit inputs;};

    nixosModules = import ./modules/nixos;
    homeModules = import ./modules/home;

    devShells = forAllSystems (
      system: let
        pkgs = nixpkgs.legacyPackages.${system};
      in {
        default = import ./shell.nix {inherit pkgs;};
      }
    );

    nixosConfigurations = {
      naboshi = mkNixosConfiguration "x86_64-linux" [./hosts/naboshi];
      futro = mkNixosConfiguration "x86_64-linux" [./hosts/futro];
      kitsunebi = mkNixosConfiguration "x86_64-linux" [./hosts/kitsunebi];
    };

    homeConfigurations = {
      "neo@kitsunebi" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
        modules = [
          ./users/neo/home
          ./users/neo/home/hosts/kitsunebi
        ];
      };
      "susagi@naboshi" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit inputs outputs;
        };
        modules = [
          ./users/susagi/home
          ./users/susagi/home/hosts/naboshi
        ];
      };
    };
  };
}
