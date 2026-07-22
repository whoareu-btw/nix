{ config, pkgs, ... }:

let
  customWaylandScript = pkgs.writeShellScript "start-suisway" ''
    if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
      . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
    fi

    exec ${pkgs.sway}/bin/sway
  '';

  customWaylandSession = (pkgs.writeTextDir "/share/wayland-sessions/suisway.desktop" ''
    [Desktop Entry]
    Name=Suisway
    Comment=Kyou mo kawaii
    Exec=${customWaylandScript}
    Type=Application
  '') // { providedSessions = [ "suisway" ]; };
in
{
  services.displayManager.sessionPackages = [ customWaylandSession ];
}
