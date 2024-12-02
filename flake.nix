{
  description = "James' system";

  inputs = {
    # Package sets
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-24.11-darwin";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    # Environment/system management
    home-manager.url = "github:nix-community/home-manager/release-24.11";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    nix-darwin.url = "github:LnL7/nix-darwin";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
  };

  outputs = inputs@{ self, nix-darwin, home-manager, nixpkgs, nixpkgs-unstable }: {
    darwinConfigurations = {
      "ML-1299" = nix-darwin.lib.darwinSystem {
        system = "aarch64-darwin";
        modules = [
          ./darwin.nix
          home-manager.darwinModules.home-manager
          {
            home-manager = {
              users."james.sawle" = import ./home.nix;
              extraSpecialArgs = {
                pkgs-unstable = nixpkgs-unstable.legacyPackages.aarch64-darwin;
               };
            };
            users.users."james.sawle".home = "/Users/james.sawle";
          }
        ];
        specialArgs = { inherit inputs; };
      };
    };
  };
}
