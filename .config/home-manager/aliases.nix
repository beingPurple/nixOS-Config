{
  ls = "ls -al";
  hm = "home-manager switch --flake /home/noelle/.config/home-manager#noelle --impure && cd -- && echo 'Remember to source your shell config'";
  eflake = "nvim ~/.config/home-manager/flake.nix";
  ehome = "nix flake update ~/.config/home-manager/ && nvim ~/.config/home-manager/home.nix";
  ghome = "cd ~";
  roll = "sudo nixos-rebuild switch --rollback";
  ealias = "nvim ~/.config/home-manager/aliases.nix";
  efish = "nvim .config/home-manager/fishConfig.nix";
  file = "sudo yazi";
}
