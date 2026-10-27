{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    vim
    tmux
    zellij
    dnsmasq
    distrobox
  ];
}
