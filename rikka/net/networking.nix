{ ... }:

{
  networking.networkmanager.enable = true;
  
  networking.firewall = {
    enable = true;
    allowedTCPPorts = [];
    allowedUDPPortRanges = [];
    trustedInterfaces = [ "virbr0" ];
  };

  environment.etc."NetworkManager/conf.d/default-wifi-powersave.conf".text = ''
    [connection]
    wifi.powersave=2
  '';
}
