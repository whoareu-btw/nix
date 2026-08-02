{ pkgs, ... }:

{
  services.xserver = {
    enable = true;

    displayManager = {
      lightdm.enable = true;
    };

    desktopManager = {
      xfce.enable = true;
    };

    videoDrivers = [ "intel" ];
    deviceSection = [
      Option "AccelMethod" "sna"
      Option "DRI" "crocus"
    ];

    excludePackages = with pkgs; [
      xterm
    ];
  };
}
