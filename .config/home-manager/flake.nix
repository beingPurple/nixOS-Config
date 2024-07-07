{
  description = "NixOS on WSL2 configuration with Home Manager";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixos-wsl = {
      url = "github:nix-community/NixOS-WSL";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, nixos-wsl, home-manager, nixvim, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        overlays = [
          (final: prev: {
            vimPlugins = prev.vimPlugins // {
              vaporlush = prev.vimUtils.buildVimPlugin {
                name = "vaporlush";
                src = prev.fetchFromGitHub {
                  owner = "adamkali";
                  repo = "vaporlush";
                  rev = "master";
                  sha256 = "sha256-9Q5NmpStRqh63AgF7buFoaZzjrzd0l7TJkSHg/8kSe0=";
                };
                postPatch = ''
                  sed -i 's/vim.o.background = "dark"/vim.o.background = "dark"\n    vim.api.nvim_set_option("termguicolors", true)\n    vim.opt.winblend = 30\n    vim.opt.pumblend = 30\n    vim.opt.transparency = 0.8/' colors/vaporlush.lua
                '';
              };
            };
          })
        ];
        config.allowUnfree = true;
      };
    in {
      nixosConfigurations.mywsl = nixpkgs.lib.nixosSystem {
        system = "x86_64-linux"; 
        modules = [
          nixos-wsl.nixosModules.wsl
          ./configuration.nix
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;
            home-manager.users.noelle = import ./home.nix;
          }
        ];
      };

      homeConfigurations."noelle" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          ./home.nix
          nixvim.homeManagerModules.nixvim
        ];
      };
    };
}
