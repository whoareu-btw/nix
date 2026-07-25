{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    swaybg
    swayidle
    swaylock
    waybar
    quickshell
    pavucontrol
    networkmanagerapplet
    ristretto
    fuzzel
    libnotify
    mako
    nwg-look
    grim
    slurp
    wlogout
    autotiling
    fastfetch
    btop
    htop
    foot
    emote
    wl-clipboard
  ];
}
