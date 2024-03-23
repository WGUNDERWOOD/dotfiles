{
    inputs = {
        nixpkgs.url = "nixpkgs/nixos-23.11";
        #home-manager.url = "github:nix-community/home-manager";
        #home-manager.inputs.nixpkgs.follows = "nixpkgs";
    };

    outputs = inputs@{ nixpkgs,
        #home-manager,
        ... }: {
        nixosConfigurations = {
            libra = inputs.nixpkgs.lib.nixosSystem {
                system = "x86_64-linux";
                modules = [
                    ./machines/configuration-libra.nix
                    #home-manager.nixosModules.home-manager {
                        #home-manager.useGlobalPkgs = true;
                        #home-manager.useUserPackages = true;
                        #home-manager.users.will = {
                            #imports = import ./config/home.nix;
                            #system.stateVersion = "23.05";
                        #};
                    #}
                ];
            };
        };
    };
}
