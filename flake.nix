{
  description = "JRhin Flake";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-unstable";

    hyprland.url = "github:hyprwm/Hyprland";

    home-manager = {
        url = "github:nix-community/home-manager";
        inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
  in {
    nixosConfigurations = {
      thinkpad = nixpkgs.lib.nixosSystem {
        specialArgs = {inherit inputs;};
        modules = [
          ./hosts/thinkpad/configuration.nix
        ];
      };
    };
  };
}
