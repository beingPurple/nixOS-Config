{
  description = "Home Manager configuration";

  inputs = {

    #inputs.nixvim = {
     # url = "github:nix-community/nixvim";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      # url = "github:nix-community/nixvim/nixos-24.05";

      #inputs.nixpkgs.follows = "nixpkgs";
    #};

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
	#pkgs = nixpkgs.legacyPackages.x86_64-linux; # Adjust this for your system if needed
        modules = [ 
	 "/home/noelle/.config/home-manager/home.nix"
#	/home/noelle/.config/home-manager/home.nix
	#/home/noelle/.config/home-manager/home.nix 
	#home-manager.nixosModules.home-manager
        nixvim.homeManagerModules.nixvim
       ];
    };
  };
}
