{
  description = "yzd's NixOS";
  inputs = {
    nixpkgs.url = "nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }: {
    nixosConfigurations.zenith = nixpkgs.lib.nixosSystem {
      system = "x86_64-linux";
      modules = [
        ./configuration.nix
				home-manager.nixosModules.home-manager {
        home-manager = {
          useGlobalPkgs = true;
	    		useUserPackages = true;
	    		users.yzd = import ./home.nix;
	    		backupFileExtension = "backup";
	      };
			 }
      ];
    };
  };
}
