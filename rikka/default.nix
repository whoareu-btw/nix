{ imports, ... }:

{
  imports = [
    ./net/default.nix
    ./env/default.nix
    ./dev/default.nix
    ./zram/default.nix
    ./graphic/default.nix
  ];
}
