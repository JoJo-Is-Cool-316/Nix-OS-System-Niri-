{ pkgs, ... }:

{
  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users."hunter316" = {
    isNormalUser = true;
    description = "hunter316";
    extraGroups = [ "networkmanager" "wheel" "nordvpn" ];
    packages = with pkgs; [
    #  thunderbird
    ];
  };

  # Installing Podman for containers
  virtualisation.podman = {
    enable = true;
    dockerCompat = true; # Creates a `docker` alias
    defaultNetwork.settings.dns_enabled = true; # Enables container networking
  };

  # Allowing Zed Editor to download tools like roslyn-language-server
  programs.nix-ld.enable = true;

  # Enable Flatpak support
  services.flatpak.enable = true;

  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;
}
