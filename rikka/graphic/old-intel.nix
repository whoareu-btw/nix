{ pkgs, inputs, ... }:

let
  unstable = import inputs.nixpkgs-unstable {
    system = pkgs.stdenv.hostPlatform.system;
  };
in
{
  boot.kernelParams = [
    "i915.enable_dc=0"
    "i915.enable_fbc=0"
    "i915.reset=1"
  ];

  hardware = {
    graphics = {
      enable = true;
      extraPackages = with pkgs; [
      #  unstable.intel-vaapi-driver
      #  vaapi-intel-hybrid
      #  intel-media-sdk
      ];
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
    libva
    libva-utils
    powertop
    pciutils
  ];
}
