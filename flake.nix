{
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-24.11";
    home-manager.url = "github:nix-community/home-manager/release-24.11";
  };
  outputs = inputs @ {
    nixpkgs,
    home-manager,
    ...
  }: {
    nixosConfigurations = let
      systemArch = "x86_64-linux";
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
        modules = [
          ./machines/configuration-libra.nix
          homeManager
        ];
      };
      xanth = inputs.nixpkgs.lib.nixosSystem {
        system = systemArch;
        modules = [
          ./machines/configuration-xanth.nix
          homeManager
        ];
      };
    };
  };
}
