{ imports, ... }:

{
  imports = [
    ./tty/default.nix
    ./sway/default.nix
    ./font/default.nix
    ./user/default.nix
    ./shell/default.nix
    ./audio/default.nix
    ./logind/default.nix
    ./thunar/default.nix
    ./flatpak/default.nix
    ./package/default.nix
    ./libinput/default.nix
  ];
}
