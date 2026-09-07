{ pkgs, ... }:

{
  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
        intel-media-driver
      ];
    };

    intel-gpu-tools.enable = true;
  };

  environment.sessionVariables = {
    LIBVA_DRIVER_NAME = "iHD";
  };
  
  environment.systemPackages = with pkgs; [
    libva
    libva-utils
    powertop
    pciutils
  ];
}
