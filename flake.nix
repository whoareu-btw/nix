{
  description = "Haruuuuuu";

  inputs = {
    nixpkgs.url = "nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    ved = {
      url = "github:whoareu-btw/ved";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nowplay = {
      url = "github:whoareu-btw/nowplay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.tsuyu = nixpkgs.lib.nixosSystem {

      system = "x86_64-linux";

      specialArgs = {
        inherit inputs;
      };

      modules = [
        ./configuration.nix
        home-manager.nixosModules.home-manager
        {
          home-manager = {
            useGlobalPkgs = true;
            users.haru = import ./hanabi/home.nix;
            backupFileExtension = "backup";
          };
        }
        ({ pkgs, ... }: {
          environment.systemPackages = [
            inputs.ved.packages.${pkgs.stdenv.hostPlatform.system}.default
            inputs.nowplay.packages.${pkgs.stdenv.hostPlatform.system}.nowplay-layer-shell
          ];
        })
      ];
    };
  };
}
