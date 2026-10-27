{ ... }:

{
  imports = [
    ./tty/default.nix
    #./dwm/default.nix
    ./sway/default.nix
    ./font/default.nix
    ./user/default.nix
    #./gnome/default.nix
    ./shell/default.nix
    ./audio/default.nix
    ./logind/default.nix
    ./thunar/default.nix
    ./flatpak/default.nix
    ./polkit/default.nix
    ./package/default.nix
  ];
}
