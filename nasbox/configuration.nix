{ config, pkgs, ... }:
{
	imports =
		[
			/etc/nixos/hardware-configuration.nix

			../nix-modules/common.nix
			../nix-modules/networking.nix
		];

	homelab.network.hostname = "nasbox";
	homelab.network.staticAssignment = {
		address = "192.168.100.50";
		prefixLength = 24;
		interface = "ens18";
	};

	# open ports for NFS sharing
	networking.firewall = {
		allowedTCPPorts = [ 
			111	# rpcbind
			2049 # NFS
			4000 # statdPort
			4001 # lockdPort
			4002 # mountdPort
		];
		allowedUDPPorts = [ 
			111
			2049
			4000
			4001
			4002
		];
	};

	fileSystems."/mnt/homelab-data" = {
		device = "/dev/disk/by-uuid/40b750ff-e802-4792-97b5-b9dc98d322ec"; 
		fsType = "ext4";
		options = [ "defaults" "noatime" "nofail" ];
	};

	services.nfs.server = {
		enable = true;
		exports = ''
			/mnt/homelab-data/proxmox 192.168.100.0/24(rw,sync,no_subtree_check,no_root_squash)
			/mnt/homelab-data/files 192.168.100.0/24(rw,sync,no_subtree_check)
		'';
		# fixed ports for firewall compatibility
		statdPort = 4000;
		lockdPort = 4001;
		mountdPort = 4002;
	};

	system.stateVersion = "25.05"; # DO NOT CHANGE
}
