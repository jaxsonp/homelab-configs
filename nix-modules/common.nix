{ config, pkgs, ... }:
{
	nixpkgs.config.allowUnfree = true;

	environment.systemPackages = with pkgs; [
		vim
		git
		wget
		curl
		tmux
		rsync
		tree
	];
	environment.variables.EDITOR = "vim";

	users.users.jaxson = {
		isNormalUser = true;
		description = "Jaxson Pahukula";
		extraGroups = [ "networkmanager" "wheel" "docker" ];
		packages = with pkgs; [];
	};

	# enable ssh
	services.openssh = {
		enable = true;
	};

	time.timeZone = "Pacific/Honolulu";
	i18n.defaultLocale = "en_US.UTF-8";

	# enable flakes
	nix.settings.experimental-features = [ "nix-command" "flakes" ];
	
	# garbage collection
	nix.gc = {
		automatic = true;
		dates = "weekly";
		options = "--delete-older-than 30d";
	};
}
