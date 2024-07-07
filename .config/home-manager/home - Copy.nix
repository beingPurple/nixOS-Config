{ pkgs, ... }:

let
  shellAliases = import ./aliases.nix;
in
{
  home = {
    username = "noelle";
    homeDirectory = "/home/noelle";
    stateVersion = "24.05";
  };

  imports = [ 
    # Your other imports
  ];

  programs.bash = {
    enable = true;
    initExtra = ''
      if [ -e $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh ]; then 
        . $HOME/.nix-profile/etc/profile.d/hm-session-vars.sh
      fi
    '';
    inherit shellAliases;
  };
  
  programs.nixvim = {
    enable = true;
    extraConfigVim = ''
      " Put your extra Neovim configuration here
    '';
  };

  programs.fish = {
    enable = true;
    interactiveShellInit = ''
      set fish_greeting # Disable greeting
      # Only load grc if it's installed
      if type -q grc
        set -U fish_color_command green
        if test -e ${pkgs.grc}/etc/grc.fish
          source ${pkgs.grc}/etc/grc.fish
        end
      end
    '';
    inherit shellAliases;
    plugins = [
      {
        name = "z";
        src = pkgs.fetchFromGitHub {
          owner = "jethrokuan";
          repo = "z";
          rev = "e0e1b9dfdba362f8ab1ae8c1afc7ccf62b89f7eb";
          sha256 = "0dbnir6jbwjpjalz14snzd3cgdysgcs3raznsijd6savad3qhijc";
        };
      }
    ];
  };

  home.sessionPath = [
    "$HOME/.nix-profile/bin"
  ];

  programs.home-manager.enable = true;

  home.packages = with pkgs; [
    git
    gotop
    wget
    yazi
    fish
    grc
  ];

  programs.git.enable = true;
}
