{ pkgs, inputs, ... }:

let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
  };
in
{
  hardware = {
    graphics = {
      enable = true;
      #extraPackages = with pkgs; [
      #  unstable.intel-vaapi-driver
      #  intel-media-sdk
      #];
    };

    intel-gpu-tools.enable = true;
  };

  #nixpkgs.config.permittedInsecurePackages = [
    #  "intel-media-sdk-23.2.2"
    #];
  #};

  #environment.sessionVariables = {
  #  LIBVA_DRIVER_NAME = "i965";
  #};
  
  environment.systemPackages = with pkgs; [
    efibootmgr
    libva
    libva-utils
    powertop
    pciutils
  ];
}
