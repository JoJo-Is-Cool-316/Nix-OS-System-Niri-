{ pkgs, ... }:

{
  # List packages installed in system profile.
  # You can use https://search.nixos.org/ to find more packages (and options).

  environment.systemPackages = with pkgs; [
    # Browsers
    brave
    librewolf

    # Media
    freetube
    vlc

    # Office Work
    onlyoffice-desktopeditors

    # Editors and terminal workflow
    neovim
    zed-editor
    alacritty
    ghostty
    tmux

    # Wayland and desktop utilities
    xwayland-satellite
    noctalia
    brightnessctl

    # Containers and file sync
    distrobox
    syncthing

    # Security and notes 
    keepassxc
    obsidian

    # CLI and app management
    git
    wget
    fastfetch
    gnome-software
    flatpak
  ];
}
