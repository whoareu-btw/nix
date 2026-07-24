{ config, pkgs, ... }:

{
  security.polkit.enable = true;
  systemd.user.services.lxqt-policykit-agent = {
    description = "lxqt-policykit-agent";
    wantedBy = [ "graphical-session.target" ];
    wants = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      Type = "simple";
      ExecStart = "${pkgs.lxqt.lxqt-policykit}/bin/lxqt-policykit-agent";
      Restart = "on-failure";
      RestartSec = 1;
      TimeoutStopSec = 10;
    };
  };
    
  environment.systemPackages = with pkgs; [
    lxqt.lxqt-policykit
  ];
}
