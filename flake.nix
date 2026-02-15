{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    nixpkgs-stable.url = "github:nixos/nixpkgs/nixos-25.05";
    nixpkgs-old-stable.url = "github:nixos/nixpkgs/nixos-24.11";

    # broke waybar 
    home-manager.url = "github:nix-community/home-manager/release-25.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    core.url = "git+https://git.portuus.de/sid/nix-core.git?ref=release-25.11";
    core.inputs.nixpkgs.follows = "nixpkgs";

    #    core-dev.url = "github:Daenariz/nix-core/feature/plecs";
    # ha-test.url = "github:Daenariz/nix-core/feature/home-assistant-oci";

    nixos-mailserver.url = "gitlab:simple-nixos-mailserver/nixos-mailserver/";
    nixos-mailserver.inputs.nixpkgs.follows = "nixpkgs";

    nixvim.url = "github:nix-community/nixvim/nixos-25.11";
    nixvim.inputs.nixpkgs.follows = "nixpkgs";

    nur.url = "github:nix-community/NUR";
    nur.inputs.nixpkgs.follows = "nixpkgs";

    sops-nix.url = "github:Mic92/sops-nix";
    sops-nix.inputs.nixpkgs.follows = "nixpkgs";

    stylix.url = "github:danth/stylix/release-25.11";
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

      lib = nixpkgs.lib.extend (final: prev: inputs.core.lib or { });

      mkNixosConfiguration =
        system: modules:
        nixpkgs.lib.nixosSystem {
          inherit system modules;
          specialArgs = {
            inherit inputs outputs lib;
          };
        };
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
        naboshi = mkNixosConfiguration "x86_64-linux" [ ./hosts/naboshi ];
        # futro = mkNixosConfiguration "x86_64-linux" [ ./hosts/futro ];
        # kyoujin = nixpkgs.lib.nixosSystem {
        #   specialArgs = {
        #     inherit inputs outputs;
        #   };
        #   modules = [ ./hosts/kyoujin ];
        # };
        # kitsunebi = nixpkgs.lib.nixosSystem {
        #   specialArgs = {
        #     inherit inputs outputs;
        #   };
        #   modules = [ ./hosts/kitsunebi ];
        # };
        # akiyama = nixpkgs.lib.nixosSystem {
        #   specialArgs = {
        #     inherit inputs outputs;
        #   };
        #   modules = [ ./hosts/akiyama ];
        # };
        # kiichigo = nixpkgs.lib.nixosSystem {
        #   specialArgs = {
        #     inherit inputs outputs;
        #   };
        #   modules = [ ./hosts/kiichigo ];
        # };
        # naboshi = nixpkgs.lib.nixosSystem {
        #   specialArgs = {
        #     inherit inputs outputs;
        #   };
        #   modules = [ ./hosts/naboshi ];
        # };
        # futro = nixpkgs.lib.nixosSystem {
        #   specialArgs = {
        #     inherit inputs outputs;
        #   };
        #   modules = [ ./hosts/futro ];
        # };
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
