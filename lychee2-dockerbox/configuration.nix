{ config, pkgs, ... }:

{
	imports =
		[
			/etc/nixos/hardware-configuration.nix

			../nix-modules/common.nix
			../nix-modules/networking.nix
		];

	homelab.network.hostname = "dockerbox2";
	homelab.network.staticAssignment = {
		address = "192.168.100.70";
		prefixLength = 24;
		interface = "ens18";
	};

	# temp solution
	services.tailscale = {
		enable = true;
		useRoutingFeatures = "server";
	};

	virtualisation.docker.enable = true;

	system.stateVersion = "25.05"; # DO NOT CHANGE
}
