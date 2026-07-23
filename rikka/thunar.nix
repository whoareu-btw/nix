{ config, lib, pkgs, ... }:

{
  nixpkgs.overlays = [
  (self: super: {
    thunar-archive-plugin = super.thunar-archive-plugin.overrideAttrs (old: {
      postInstall = (old.postInstall or "") + ''
        mkdir -p $out/libexec/thunar-archive-plugin
        cp ${super.xarchiver}/libexec/thunar-archive-plugin/* $out/libexec/thunar-archive-plugin/
      '';
      });
    })
  ];

  programs.thunar = {
    enable = true;
    plugins = with pkgs; [
      thunar-archive-plugin
      xarchiver
    ];
  };

  services = {
    gvfs.enable = true;
    tumbler.enable = true;
  };
}
