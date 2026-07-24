{ config, lib, ... }:

{
  networking.hostName = "tsuyu";

  users.users.haru = {
    extraGroups = [ "wheel" "libvirtd" "video" "renderer" "networkmanager" ];
    isNormalUser = true;
  };

  time.timeZone = "Asia/Jakarta";
}
