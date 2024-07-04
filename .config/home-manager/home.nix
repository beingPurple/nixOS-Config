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
      hm = "nix run home-manager/master -- switch --flake .#noelle --impure &&  echo 'Remember to source ~/.bashrc!'";
      ef = "sudo nvim ~/.config/home-manager/flake.nix";
      eh = "sudo nvim ~/.config/home-manager/home.nix";
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
