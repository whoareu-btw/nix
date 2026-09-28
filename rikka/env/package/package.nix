{ pkgs, ... }:

let
  waybarL = pkgs.waybar.override {
    gpsSupport     = false;
    mpdSupport     = false;
    niriSupport    = false;
    mprisSupport   = false;
    upowerSupport  = false;
    rfkillSupport  = false;
  };
in
{
  environment.systemPackages = with pkgs; [
    swaybg
    swayidle
    swaylock
    i3status-rust
    waybarL
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
    wf-recorder
    hwinfo
    lshw
    dmidecode
  ];
}
