{ pkgs }:

{
  enable = true;
  
  plugins = [
    {
      name = "pure";
      src = pkgs.fetchFromGitHub {
        owner = "pure-fish";
        repo = "pure";
        rev = "v4.4.1";  # You can update this to the latest version
        sha256 = "sha256-2b2/LZXSchHnPKyjwAcR/oCY38qJ/7Dq8cJHrJmdjoc=";
      };
    }
  ];

  interactiveShellInit = ''
    set fish_greeting ""  # Disable the default greeting
    
    # Pure prompt settings (optional)
    set pure_color_primary brblue
    set pure_color_info cyan
    set pure_color_mute brblack
    set pure_color_success green
    set pure_color_normal normal
    set pure_color_danger red
    set pure_color_light white
    set pure_color_warning E92888 #yellow
    set pure_color_dark black

    set pure_symbol_prompt "✨"
    
    # You can add more Fish configuration here
    set pure_color_current_directory E92888
    set pure_color_git_branch E92888 
    set pure_color_git_dirty white
  '';

  functions = {
    # Add any custom Fish functions here
  };

  shellAliases = {
    # Add any Fish-specific aliases here
  };
}
