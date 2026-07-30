{ pkgs, ... }:

{
  services.xserver = {
    enable = true;

    displayManager = {
      lightdm.enable = true;
    };

    desktopManager = {
      mate.enable = true;
    };

    videoDrivers = [ "modesetting" ];

    excludePackages = with pkgs; [
      xterm
    ];
  };
}
