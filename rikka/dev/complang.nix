{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    gcc
    rustc
    cargo
    rust-analyzer
    clang
    clang-tools
    python315
    pyright
    lua
    lua-language-server
    bash-language-server
    nil
  ];
}
