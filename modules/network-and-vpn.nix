{ config, pkgs, ... }:

let
  # Import unstable nixpkgs using your current architecture and unfree/config settings
  unstable = import <nixos-unstable> {
    inherit (pkgs) system;
    config = config.nixpkgs.config;
  };
in
{
  imports = [
    # Pull the NordVPN module definition directly from the unstable channel
    ( <nixos-unstable> + "/nixos/modules/services/networking/nordvpn.nix" )
  ];

  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking
  networking.networkmanager.enable = true;

  # NordVPN
  services.nordvpn = {
    enable = true;
    package = unstable.nordvpn;
  };

  # Allow users in the `nordvpn` group to update DNS/routing via systemd-resolved without extra prompts
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      const nordvpnActions = [
        "org.freedesktop.resolve1.set-domains",
        "org.freedesktop.resolve1.set-dnssec",
        "org.freedesktop.resolve1.set-default-route"
      ];

      if (nordvpnActions.indexOf(action.id) >= 0 &&
          subject.isInGroup("nordvpn")) {
        return polkit.Result.YES;
      }
    });
  '';

  # Keep firewall enabled; "loose" reverse path filtering helps avoid dropping VPN traffic
  networking.firewall.enable = true;
  networking.firewall.checkReversePath = "loose";

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
}
