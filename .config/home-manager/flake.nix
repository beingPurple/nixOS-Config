{
  description = "Home Manager configuration";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, nixvim, ... }:
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
                  sha256 = "sha256-9Q5NmpStRqh63AgF7buFoaZzjrzd0l7TJkSHg/8kSe0="; # Replace with the correct hash
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
      homeConfigurations."noelle" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ 
          /home/noelle/.config/home-manager/home.nix
          nixvim.homeManagerModules.nixvim
        ];
      };
    };
}

