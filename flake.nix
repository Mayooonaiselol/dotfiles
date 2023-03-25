{
  description = "Mayo's NixOS System Configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-22.11";
    nixpkgs-f2k.url = "github:fortuneteller2k/nixpkgs-f2k";
    home-manager = {
      url = github:nix-community/home-manager;
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixpkgs-f2k }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        mayo = lib.nixosSystem {
          inherit system;
          modules = [
            {
              nixpkgs.overlays = [
                nixpkgs-f2k.overlays.compositors # for X11 compositors
                nixpkgs-f2k.overlays.window-managers # window managers such as awesome or river
                # nixpkgs-f2k.overlays.stdenvs # stdenvs with compiler optimizations, and library functions for optimizing them
                # nixpkgs-f2k.overlays.default # for all packages
              ];
            }

            ./configuration.nix

            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.mayo = {
                imports = [ ./home.nix ];
              };
            }
          ];
        };
      };
      homeConf = {
        mayo = home-manager.lib.homeManagerConfiguration {
          inherit system pkgs;
          username = "mayo";
          homeDirectory = "/home/mayo";
          configuration = {
            imports = [
              ./home.nix
            ];
          };
        };
      };
    };
}
