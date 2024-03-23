{
  #description = "An example NixOS configuration";

  inputs = {
    nixpkgs = { url = "nixpkgs/nixos-23.11"; };
    #nur = { url = "github:nix-community/NUR"; };
  };

  outputs = inputs:
  {
    nixosConfigurations = {

      libra = inputs.nixpkgs.lib.nixosSystem {
        system = "x86_64-linux";
        modules = [
          ./machines/configuration-libra.nix
        ];
        #specialArgs = { inherit inputs; };
      };
    };
  };
}
