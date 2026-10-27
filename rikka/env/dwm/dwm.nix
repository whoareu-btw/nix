{ pkgs, ... }:
{
  services.displayManager.ly.enable = true;

  services.xserver = {
    enable = true;
    displayManager.lightdm.enable = false;
  };

  services.xserver.displayManager.sessionCommands = ''
    [ -x "$HOME/.config/dwm/autostart.sh" ] && "$HOME/.config/dwm/autostart.sh" &
  '';

  services.xserver.windowManager.dwm = {
    enable = true;
    package = (pkgs.dwm.override {
      conf = builtins.readFile ./config.h;
    }).overrideAttrs (old: {
      postPatch = (old.postPatch or "") + "\n" + ''
        cp ${./bsp.c} bsp.c
        cp ${./dock.h} dock.h
        sed -i 's|#include "util.h"|#include "util.h"\n#include "dock.h"|' dwm.c
        sed -i 's|if (!wintoclient(ev->window))|if (isdock(dpy, ev->window)) { XMapWindow(dpy, ev->window); return; }\n\tif (!wintoclient(ev->window))|' dwm.c
        sed -i 's|bh = drw->fonts->h + 2;|bh = 28;|' dwm.c
        sed -i '/XMapRaised(dpy, m->barwin);/d' dwm.c
        sed -i '/^attach(Client \*c)$/,/^}$/c\
        attach(Client *c)\
        {\
        Client **tc;\
        for (tc = &c->mon->clients; *tc; tc = &(*tc)->next);\
        *tc = c;\
        c->next = NULL;\
        }' dwm.c
      '';
    });
  };

  services.libinput = {
    enable = true;
    touchpad.naturalScrolling = true;
    touchpad.tapping = true;
  };

  services.xserver.excludePackages = with pkgs; [
    xterm
  ];

  environment.systemPackages = with pkgs; [
    kitty
    xwallpaper
    picom
    quickshell
    dunst
  ];
}
