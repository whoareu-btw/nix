{ imports, ... }:

{
  imports = [
    ./pod-vm.nix
    ./neovim.nix
    ./devpkg.nix
    ./complang.nix
  ];
}
