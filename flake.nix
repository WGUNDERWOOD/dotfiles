{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    home-manager.url = "github:nix-community/home-manager/release-26.05";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
  };
  outputs = inputs @ {home-manager, ...}: {
    nixosConfigurations = let
      systemArch = "x86_64-linux";
      nixpkgs-unstable = inputs.nixpkgs-unstable.legacyPackages.${systemArch};
      homeManager = {
        imports = [
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.will = {
              imports = import ./config/home.nix;
              home.stateVersion = "23.05";
            };
          }
        ];
      };
    in {
      libra = inputs.nixpkgs.lib.nixosSystem {
        system = systemArch;
        specialArgs = {inherit nixpkgs-unstable;};
        modules = [
          ./machines/configuration-libra.nix
          homeManager
        ];
      };
      xanth = inputs.nixpkgs.lib.nixosSystem {
        system = systemArch;
        specialArgs = {inherit nixpkgs-unstable;};
        modules = [
          ./machines/configuration-xanth.nix
          homeManager
        ];
      };
    };
  };
}
