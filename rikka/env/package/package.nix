{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    pavucontrol
    networkmanagerapplet
    brightnessctl
    ristretto
    fuzzel
    libnotify
    rofi
    fastfetch
    btop
    htop
    foot
    emote
    hwinfo
    lshw
    dmidecode
  ];
}
