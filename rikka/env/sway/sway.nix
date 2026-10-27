{ pkgs, ... }:

let
  waybarL = pkgs.waybar.override {
    gpsSupport     = false;
    mpdSupport     = false;
    niriSupport    = false;
    cavaSupport    = false;
    evdevSupport   = false;
    sndioSupport   = false;
    upowerSupport  = false;
    rfkillSupport  = false;
    systemdSupport = false;
    experimentalPatches = false;
  };
in
{
  services.displayManager.ly = {
    enable=true;
  };

  programs.sway = {
    enable = true;
    xwayland.enable = true;
  };

  environment.systemPackages = with pkgs; [
    swaybg
    swayidle
    swaylock
    i3status-rust
    waybarL
    quickshell
    dunst
    grim
    slurp
    autotiling-rs
    foot
    wl-clipboard
    wf-recorder
    fuzzel
    kitty
  ];
}
