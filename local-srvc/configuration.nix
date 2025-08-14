{ config, pkgs, ... }:
{
	imports = [
		./hardware-configuration.nix
	];

# bootloader
	boot.loader.grub.enable = true;
	boot.loader.grub.device = "/dev/sda";
	boot.loader.grub.useOSProber = true;

	networking = {
		hostName = "local-srvc";
		networkmanager.enable = true;
		interfaces.ens18 = {
			ipv4.addresses = [{
				address = "10.10.1.2";
				prefixLength = 24;
			}];
		};
		defaultGateway = "10.10.1.1";
		nameservers = [ "10.10.1.1" "1.1.1.1" "8.8.8.8" ];
	};

	time.timeZone = "Pacific/Honolulu";

	i18n = { 
		defaultLocale = "en_US.UTF-8";
		extraLocaleSettings = {
			LC_ADDRESS = "en_US.UTF-8";
			LC_IDENTIFICATION = "en_US.UTF-8";
			LC_MEASUREMENT = "en_US.UTF-8";
			LC_MONETARY = "en_US.UTF-8";
			LC_NAME = "en_US.UTF-8";
			LC_NUMERIC = "en_US.UTF-8";
			LC_PAPER = "en_US.UTF-8";
			LC_TELEPHONE = "en_US.UTF-8";
			LC_TIME = "en_US.UTF-8";
		};
	};

# Configure keymap in X11
	services.xserver.xkb = {
		layout = "us";
		variant = "";
	};

# Define a user account. Don't forget to set a password with ‘passwd’.
	users.users.jaxson = {
		isNormalUser = true;
		description = "Jaxson Pahukula";
		extraGroups = [ "networkmanager" "wheel" "docker" ];
		packages = with pkgs; [];
	};

# Allow unfree packages
	nixpkgs.config.allowUnfree = true;

# List packages installed in system profile. To search, run:
# $ nix search wget
	environment.systemPackages = with pkgs; [
		vim # Do not forget to add an editor to edit configuration.nix! The Nano editor is also installed by default.
			wget
			git
	];

	virtualisation.docker = {
		enable = true;
		rootless.enable = true;
	};


	services.openssh.enable = true;

# This value determines the NixOS release from which the default
# settings for stateful data, like file locations and database versions
# on your system were taken. It‘s perfectly fine and recommended to leave
# this value at the release version of the first install of this system.
# Before changing this value read the documentation for this option
# (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
	system.stateVersion = "25.05"; # Did you read the comment?

}
