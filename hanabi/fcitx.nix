{ pkgs,  ... }:

{
  i18n = {
    inputMethod = {
      enable = true;
      type = "fcitx5";
      fcitx5 = { 
        addons = with pkgs; [
          fcitx5-gtk
          fcitx5-mozc
          fcitx5-tokyonight
          kdePackages.fcitx5-configtool
        ];

        waylandFrontend = true;

        settings = {
          addons = {
            classicui = {
              globalSection = {
                Theme = "Tokyonight-Storm";
                DarkTheme = "Tokyonight-Storm";
              };
            };
          };

          globalOptions = {
            Hotkey = {
              EnumerateWithTriggerKeys = true;
            };
            "Hotkey/TriggerKeys" = {
               "0" = "Control+Shift_R";
            };
          };

          inputMethod = {
            GroupOrder = {
              "0" = "Default";
            };
            "Groups/0" = {
              "Default Layout" = "us";
              DefaultIM = "mozc";
              Name = "Default";
            };
            "Groups/0/Items/0" = {
              Name = "keyboard-us";
            };
            "Groups/0/Items/1" = {
              Name = "mozc";
            };
          };

        };
      };
    };
  };
}
