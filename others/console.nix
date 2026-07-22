{ config, pkgs, ... }:

{
   console = {
      enable = true;
      earlySetup = true;
      keyMap = "us";
      font = "${pkgs.terminus_font}/share/consolefonts/ter-118b.psf.gz";
      packages = [ pkgs.terminus_font ];
   };

   boot.initrd.kernelModules = [ "i915" ];
}
