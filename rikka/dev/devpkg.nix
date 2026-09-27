{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    vim
    tmux
    zellij
    qemu
    dnsmasq
    distrobox
  ];
}
