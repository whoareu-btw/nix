# NIXOS CONFIGURATION

{ config, lib, pkgs, inputs, ... }:

let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
  };
in
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

    kernelPackages = pkgs.linuxKernel.packages.linux_6_12;  #pkgs.linuxKernel.packages.linux_xanmod;

    #kernelParams = [
    #  "i915.enable_dc=0"
    #  "i915.enable_fbc=0"
    #  "i915.reset=1"
    #];

  };

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        unstable.intel-vaapi-driver
        intel-media-sdk
      ];
    };

    intel-gpu-tools.enable = true;
  };

  # Network, hostname, user and timezone
  networking.networkmanager.enable = true;

  networking.hostName = "tsuyu";

  users.users.haru = {
    extraGroups = [ "wheel" "libvirtd" "video" "renderer" "networkmanager" ];
    isNormalUser = true;
  };

  time.timeZone = "Asia/Jakarta";

  # Logind
  services.logind.settings.Login = {
    HandlePowerKey = "ignore";
    HandlePowerKeyLongPress = "ignore";
  };

  # Audio
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    pulse.enable = true;
    
    wireplumber = {
      enable = true;
      extraConfig = {
        "10-disable-suspend" = {
          "monitor.alsa.rules" = [
            {
               matches = [{ "node.name" = "~alsa_input.*"; } { "node.name"  = "~alsa_output.*"; }];
               actions = { update-props = { "session.suspend-timeout-seconds" = 0; }; };
            }
          ];
        };
      };
    };

  };

  # Polkit
  security.polkit.enable = true;
  systemd.user.services.lxqt-policykit-agent = {
    description = "lxqt-policykit-agent";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.lxqt.lxqt-policykit}/bin/lxqt-policykit-agent";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
 
  # Display manager, window manager and libinput
  services.displayManager.ly = {
    enable=true;
  };

  programs.sway = {
    enable = true;
    xwayland.enable = true;
  };

  services.libinput = {
    enable = true;
    touchpad = {
      disableWhileTyping = true;
      tapping = true;
      scrollMethod = "twofinger";
      naturalScrolling = true;
    };
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "i965"; 
  };

  # All packages, including fonts and themes
  environment.systemPackages = with pkgs; [
    efibootmgr
    libva
    libva-utils
    powertop
    pciutils
    fastfetch
    waybar
    swaybg
    swayidle
    swaylock
    waybar
    pavucontrol
    networkmanagerapplet
    ristretto
    fuzzel
    lxqt.lxqt-policykit
    distrobox
    qemu
    dnsmasq
    libnotify
    mako
    nwg-look
    grim
    slurp
    wlogout
    autotiling
    btop
    htop
    foot
    zellij
    tmux
    emote
    quickshell
    wl-clipboard
    vim
    gcc
    rustc
    cargo
    rust-analyzer
    clang
    clang-tools
    python315
    pyright
    lua
    lua-language-server
    bash-language-server
    nil
    git 
    gparted
  ];

  fonts.packages = with pkgs; [
    noto-fonts
    noto-fonts-cjk-sans
    noto-fonts-color-emoji
    nerd-fonts.iosevka
    nerd-fonts.symbols-only
    nerd-fonts.jetbrains-mono
    monocraft
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes"];

  nixpkgs.config = {
    allowUnfree = true;
    permittedInsecurePackages = [
      "intel-media-sdk-23.2.2"
    ];
  };

  # GPG and firewall
  programs.gnupg.agent = {
    enable = true;
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [];
    allowedUDPPortRanges = [];
    trustedInterfaces = [ "virbr0" ];
  };

  # Container
  virtualisation.podman = {
    enable = true;
    dockerCompat = true;
  };

  # VM
  virtualisation.libvirtd.enable = true;
  programs.virt-manager.enable = true;

  # Locale
  i18n.defaultLocale = "en_US.UTF-8";

  # Shell
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
  };

  users.defaultUserShell = pkgs.zsh;

  # Flatpak and portals
  services.flatpak.enable = true;
  xdg.portal = {
    enable = true;
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
    ];
  };

  # Zram
  zramSwap = {
    enable = true;
    priority = 80;
    algorithm = "lz4";
    memoryPercent = 50;
  };

  # system.copySystemConfiguration = true; # can't be use along side flake
 
  # DONT CHANGE THIS UNLESS YOU KNOW WHAT WILL DO!
  system.stateVersion = "26.05"; # Did you read the comment?

}
