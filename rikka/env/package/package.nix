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
    fastfetch
    btop
    htop
    foot
    zellij
    tmux
    emote
    wl-clipboard
    vim
  ];
}
