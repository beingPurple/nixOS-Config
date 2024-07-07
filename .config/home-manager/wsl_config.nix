{ config, pkgs, ... }:

{
  imports = [
    <nixos-wsl/modules>
  ];

  wsl = {
    enable = true;
    defaultUser = "noelle";
    startMenuLaunchers = true;
    nativeSystemd = true;  # Enable systemd support
    wslConf.automount.root = "/mnt";
    wslConf.interop.appendWindowsPath = false;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  users.users.noelle = {
    isNormalUser = true;
    home = "/home/noelle";
    extraGroups = [ "users" "wheel" "nixbld" ];
    shell = pkgs.fish;
  };

  nix.settings.allowed-users = [ "@users" ];
  nix.settings.trusted-users = [ "root" "noelle" ];

  nix.nixPath = [
    "nixpkgs=/nix/var/nix/profiles/per-user/root/channels/nixos"
    "/nix/var/nix/profiles/per-user/root/channels"
  ];

  environment.systemPackages = with pkgs; [
    git
    neovim
    wget
    curl
    xorg.xhost  # For X11 forwarding
    xorg.xauth  # For X11 forwarding
    firefox  # Example X11 application
    vscode  # Example X11 application
  ];

  system.stateVersion = "23.11";
  
  programs.fish.enable = true;

  # X11 forwarding support
  services.openssh.enable = true;
  services.openssh.forwardX11 = true;

  # Enable dbus
  services.dbus.enable = true;

  # Remove NVIDIA-specific configuration as it's not applicable in WSL
  # hardware.nvidia = { ... };
  # hardware.opengl = { ... };
  # services.xserver.videoDrivers = [ ... ];

  # Environment variables for X11 forwarding
  environment.sessionVariables = {
    DISPLAY = ":0";
    LIBGL_ALWAYS_INDIRECT = "1";
  };

  # Optional: Enable automatic mounting of Windows drives
  fileSystems."/mnt/c" = {
    device = "/mnt/c";
    fsType = "drvfs";
    options = ["uid=1000" "gid=100" "umask=22" "fmask=111"];
  };

  # Optional: Enable Docker support
  virtualisation.docker.enable = true;
  users.users.noelle.extraGroups = [ "docker" ];
}
