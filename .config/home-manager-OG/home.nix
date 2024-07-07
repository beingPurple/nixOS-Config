{ config, pkgs, ... }:

{

  home = {
    username = "noelle";
    homeDirectory = "/home/noelle";
    stateVersion = "24.05";
  };

  programs.bash = {
    enable = true;
    initExtra = ''
      if [ -e $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh ]; then
        . $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
      fi
    '';
    shellAliases = {
      ls = "ls -al";
      rb = "sudo nixos-rebuild switch --flake #noelle";
      flake = "nix run home-manager/master -- switch --flake .#noelle";
    };
   };
  
  programs.nixvim = {
    enable = true;
    extraConfigVim = ''
      " Put your extra Neovim configuration here
    '';
  };


   home.sessionPath = [
    "$HOME/.nix-profile/bin"
  ];

  programs.home-manager.enable = true;
 # programs.nixvim.enable = true;
  home.packages = with pkgs; [
    git
  ];

  programs.git.enable = true;
}
