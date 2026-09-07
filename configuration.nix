# NIXOS CONFIGURATION

{ pkgs, ... }:

{
  imports = [       
    ./hardware-configuration.nix
    ./rikka/default.nix 
  ];

  # Bootloader, kernel, kernel parameters and kernel modules
  boot = {
    loader = {
      grub = {
        enable = true;
        device = "nodev";
        efiSupport = true;
      };

      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxKernel.packages.linux_xanmod;
  };

  environment.systemPackages = with pkgs; [
    efibootmgr
  ];

  # Nix settings and Nix config
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  nixpkgs.config.allowUnfree = true;

  # GPG 
  programs.gnupg.agent = {
    enable = true;
  };
  
  # Locale
  i18n.defaultLocale = "en_US.UTF-8";

  # system.copySystemConfiguration = true; # can't be use along side flake
 
  # DONT CHANGE THIS UNLESS YOU KNOW WHAT WILL DO!
  system.stateVersion = "26.05"; # Did you read the comment?

}
