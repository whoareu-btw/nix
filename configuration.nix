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
      limine = {
        enable = true;
        efiSupport = true;
        secureBoot = {
          enable = true;
          autoGenerateKeys = true;
          autoEnrollKeys.enable = true;
        };
        maxGenerations = 5;
        style = {
          wallpapers = [];
          backdrop = "000000";
        };
      };
      efi.canTouchEfiVariables = true;
    };

    kernelPackages = pkgs.linuxKernel.packages.linux_6_12;

    kernelParams = [
      "intel_iommu=on"
      "iommu=force"
      "iommu.passthrough=0"
      "mem_sleep_default=deep"
    ];

    extraModprobeConfig = ''
      install bluetooth ${pkgs.coreutils}/bin/false
    '';

    tmp.cleanOnBoot = true;
  };

  environment.systemPackages = with pkgs; [
    efibootmgr
  ];

  # Disabled light or something I dont want
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="leds", KERNEL=="platform::micmute|platform::mute", ATTR{trigger}="none", ATTR{brightness}="0"
    ACTION=="add", SUBSYSTEM=="leds", KERNEL=="input*::capslock|input*::numlock::input*scrolllock", ATTR{trigger}="none", ATTR{brightness}="0"
  '';

  environment.etc."libinput/local-overrides.quirks".text = ''
    [Disable TrackPoint Motion]
    MatchName=*TrackPoint*
    AttrEventCode=-REL_X;-REL_Y
  '';

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
