{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    #nixpkgs.url = "github:nixos/nixpkgs/f54c283e96c02cb8ee8710205cd1d1d249ac15d9";

    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-old-stable.url = "github:nixos/nixpkgs/nixos-24.11";
    #    nixpkgs-old-old-stable.url = "github:nixos/nixpkgs/nixos-23.11";

    home-manager.url = "github:nix-community/home-manager";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    core.url = "github:sid115/nix-core/";
    #    core.url = "github:sid115/nix-core/5bc751f291c50f1cb953d40670094599dbaf2729";
    #core.url = "github:Daenariz/nix-core/feature/gaming-search-engines";
    core.inputs.nixpkgs.follows = "nixpkgs";

    core-dev.url = "github:Daenariz/nix-core/feature/plecs";
    ha-test.url = "github:Daenariz/nix-core/feature/home-assistant-oci";

    nixos-mailserver.url = "gitlab:simple-nixos-mailserver/nixos-mailserver/53007af63fade28853408370c4c600a63dd97f41";
    nixos-mailserver.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    #stylix.url = "github:danth/stylix/a88c4d264a4379b7fe5a9e75ed51bea96f8dd407";
    stylix.url = "github:danth/stylix";
    stylix.inputs.nixpkgs.follows = "nixpkgs";

    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.6.0";

  };

  outputs =
    {
      self,
      nixpkgs,
      home-manager,
      ...
    }@inputs:
    let
      inherit (self) outputs;
      supportedSystems = [
        "x86_64-linux"
        "aarch64-linux"
      ];
      forAllSystems = nixpkgs.lib.genAttrs supportedSystems;
    in
    {
      packages = forAllSystems (system: import ./pkgs nixpkgs.legacyPackages.${system});

      overlays = import ./overlays { inherit inputs; };

      nixosModules = import ./modules/nixos;
      homeModules = import ./modules/home;

      devShells = forAllSystems (
        system:
        let
          pkgs = nixpkgs.legacyPackages.${system};
        in
        {
          default = import ./shell.nix { inherit pkgs; };
        }
      );

      nixosConfigurations = {
        kitsunebi = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./hosts/kitsunebi ];
        };
        akiyama = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./hosts/akiyama ];
        };
        kiichigo = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./hosts/kiichigo ];
        };
        naboshi = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./hosts/naboshi ];
        };
        futro = nixpkgs.lib.nixosSystem {
          specialArgs = {
            inherit inputs outputs;
          };
          modules = [ ./hosts/futro ];
        };
      };

      homeConfigurations = {
        "neo@akiyama" = home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.x86_64-linux;
          extraSpecialArgs = {
            inherit inputs outputs;
          };
          modules = [
            ./users/neo/home
            ./users/neo/home/hosts/akiyama
          ];
        };
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
