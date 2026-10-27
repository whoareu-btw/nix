{ pkgs, ... }:

{
  services.displayManager.gdm.enable = true;
  services.desktopManager.gnome.enable = true;

  services.gnome = {
    games.enable = false;
    core-apps.enable = false;
    core-utilities.enable = false;
    core-developer-tools.enable = false;
    gnome-online-accounts.enable = false;
    gnome-remote-desktop.enable = false;
  };

  environment.gnome.excludePackages = with pkgs; [
    gnome-maps
    gnome-weather
    gnome-characters
    gnome-software
    gnome-contacts
  ];

  environment.systemPackages = with pkgs; [
    gnome-terminal
    gnome-calculator
    gnome-tweaks
    gnome-clocks
  ];
}
