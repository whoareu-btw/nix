{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    swaybg
    swayidle
    swaylock
    i3status-rust
    pavucontrol
    networkmanagerapplet
    ristretto
    fuzzel
    rofi
    libnotify
    mako
    nwg-look
    grim
    slurp
    autotiling
    fastfetch
    btop
    htop
    foot
    emote
    wl-clipboard
    hwinfo
    lshw
    dmidecode
  ];
}
