{ config, pkgs, ... }:
{
	imports =
		[
			/etc/nixos/hardware-configuration.nix

			../nix-modules/common.nix
			../nix-modules/networking.nix
		];

	homelab.network.hostname = "docker-master";
	homelab.network.staticAssignment = {
		address = "192.168.100.51";
		prefixLength = 24;
		interface = "ens18";
	};

	environment.systemPackages = with pkgs; [
		talosctl
	];


	system.stateVersion = "25.05"; # DO NOT CHANGE
}
