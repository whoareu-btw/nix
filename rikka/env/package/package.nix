{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    swaybg
    swayidle
    swaylock
    waybar
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
    wlogout
    autotiling
    fastfetch
    ufetch
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
