{ config, lib, pkgs, ... }:

{
    imports = [
      ./console.nix
      ./suisway.nix
      ./neovim.nix
      ./thunar.nix
    ];
}
