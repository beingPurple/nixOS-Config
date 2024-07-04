{
  description = "Home Manager configuration";

  inputs = {

    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixvim, ... }: 
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
    in {

    homeConfigurations."noelle" = home-manager.lib.homeManagerConfiguration {
	inherit pkgs;
        modules = [ 
	 "/home/noelle/.config/home-manager/home.nix"
        nixvim.homeManagerModules.nixvim
       ];
    };
  };
}
