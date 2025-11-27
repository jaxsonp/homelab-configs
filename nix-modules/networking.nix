{ config, pkgs, lib, ... }:
let
	staticAssignmentType = lib.types.submodule {
		options = {
			address = lib.mkOption {
				type = lib.types.str;
				description = "The IPv4 address";
				example = "192.168.1.10";
			};
			prefixLength = lib.mkOption {
				type = lib.types.int;
				description = "The subnet mask length";
				example = 24;
			};
			interface = lib.mkOption {
				type = lib.types.str;
				description = "The network interface name";
				example = "eth0";
			};
		};
	};
	cfg = config.homelab.network;
in {
	options.homelab.network = {
		hostname = lib.mkOption {
			type = lib.types.str; # required
			description = "The hostname for this system.";
			default = "nixos";
		};
		staticAssignment = lib.mkOption {
			type = lib.types.nullOr staticAssignmentType;
			default = null;
			description = "Defines an optional static IP assignment";
		};
	};

	config = {
		networking = {
			hostName = cfg.hostname;
			nameservers = [ "1.1.1.1" ];
			defaultGateway = "192.168.100.1";
			interfaces = lib.mkIf (cfg.staticAssignment != null) {
				${cfg.staticAssignment.interface} = {
					useDHCP = false;
					ipv4.addresses = [
						{
							address = cfg.staticAssignment.address;
							prefixLength = cfg.staticAssignment.prefixLength;
						}
					];
				};
			};
			networkmanager.enable = true;
		};
	};
}
