{ config, pkgs, ... }:

{

  imports = [
    ./fcitx.nix
  ];

  home = {
    username = "haru";
    homeDirectory = "/home/haru";
    stateVersion = "26.05";
  };

  home.pointerCursor = {
    enable = true;
    size = 24;
    x11.enable = true;
    sway.enable = true;
    gtk.enable = true;
    package = pkgs.google-cursor;
    name = "GoogleDot-Black";
  };

  gtk = {
    enable = true;
    theme = {
      name = "Orchis-Grey-Dark-Compact";
      package = pkgs.orchis-theme;
    };

    font = {
      name = "JetBrainsMono NF";
      size = 10;
    };

    iconTheme = {
      name = "Papirus-Dark";
    };
  };

  qt = {
    enable = true;
    platformTheme.name = "qtct";
    style.name = "kvantum";

    kvantum = {
      enable = true;
      settings = {
        General = {
          theme = "KvGnomeDark";
        };
      };
    };

    qt5ctSettings = {
      Appearance = {
        icon_theme = "Papirus-Dark";
        standard_dialogs = "xdgdesktopportal";
        style = "kvantum";
      };
      Fonts = {
        fixed = "\"JetBrainsMono NF,10\"";
        general = "\"JetBrainsMono NF,10\"";
      };
    };
    qt6ctSettings = {
      Appearance = {
        icon_theme = "Papirus-Dark";
        standard_dialogs = "xdgdekstopportal";
        style = "kvantum";
      };
      Fonts = {
        fixed = "\"JetBrainsMono NF,10\"";
        general = "\"JetBrainsMono NF,10\"";
      };
    };
  };

  fonts.fontconfig = {
    enable = true;
    defaultFonts = {
      emoji = [ "Noto Emoji" ];
    };
  };

  home.packages = with pkgs; [
    (papirus-icon-theme.override { 
        color = "black";
    })
  ];
  
  xdg.configFile. "gtk-4.0/settings.ini" .text = ''
    [Settings]
    gtk-theme-name=Orchis-Grey-Dark-Compact
  '';

  xdg.configFile. "kdeglobals" .text = ''
    [Icons]
    Theme=Papirus-Dark
  '';
}
