{ config, pkgs, ... }:

let
  keymaps = import ./nixvimKeymaps.nix;
  shellAliases = import ./aliases.nix;
  customTheme = builtins.readFile ./hardcore.lua;
  fishConfig = import ./fishConfig.nix { inherit pkgs; };
in
{
  home.username = "noelle";
  home.homeDirectory = "/home/noelle";
  home.stateVersion = "24.05";
  home.shellAliases = shellAliases;

  home.packages = with pkgs; [
    betterdiscordctl
    discord
    git
    gotop
    wget
    yazi
    fish
    grc
    ripgrep # for telescope.nvim
    fd # for telescope.nvim
    tree-sitter # for nvim-treesitter
    gcc # for treesitter compilation
    tmux
    nodePackages.typescript-language-server
    nodePackages.eslint
    nix-direnv
    direnv 
    yazi
    waybar
    alacritty
    wl-clipboard
  ];

  programs.home-manager.enable = true;

  programs.nixvim = {
    enable = true;
    viAlias = true;
    vimAlias = true;
    defaultEditor = true;
    options = {
      number = true;
      relativenumber = true;
      shiftwidth = 2;
      tabstop = 2;
      expandtab = true;
      mouse = "a";
      clipboard = "unnamedplus";
    };

    globals.mapleader = " ";

    keymaps = keymaps;

    plugins = {
      lualine.enable = true;
      telescope.enable = true;

      treesitter = {
        enable = true;
        ensureInstalled = "all";
      };
      gitsigns.enable = true;
      nvim-tree.enable = true;
      lsp = {
        enable = true;
        servers = {
          tsserver.enable = true;
          eslint.enable = true;
        };
      };
      cmp = {
        enable = true;
        settings = {
          mapping = {
            "<C-Space>" = "cmp.mapping.complete()";
            "<C-d>" = "cmp.mapping.scroll_docs(-4)";
            "<C-f>" = "cmp.mapping.scroll_docs(4)";
            "<C-e>" = "cmp.mapping.close()";
            "<CR>" = "cmp.mapping.confirm({ select = true })";
          };
          sources = [
            {name = "nvim_lsp";}
            {name = "buffer";}
          ];
        };
      };
    };

    extraPlugins = with pkgs.vimPlugins; [
      nvim-colorizer-lua
    ];

    extraConfigLua = ''
      ${customTheme}
      -- You can add more Lua configuration here if needed 
      require('colorizer').setup()
    '';
  };

  programs.fish = fishConfig;


  

 }
