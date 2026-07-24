{ config, pkgs, ... }:

{
  services.displayManager.ly = {
    enable=true;
  };

  programs.sway = {
    enable = true;
    xwayland.enable = true;
  };
}
