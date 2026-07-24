{ imports, ... }:

{
  imports = [
    ./pod-vm.nix
    ./neovim.nix
    ./complang.nix
  ];
}
