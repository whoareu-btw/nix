{ config, lib, ... }:

{
  networking.networkmanager.enable = true;
  
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [];
    allowedUDPPortRanges = [];
    trustedInterfaces = [ "virbr0" ];
  };
}
