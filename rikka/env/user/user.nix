{ ... }:

{
  networking.hostName = "tsuyu";

  users.users.haru = {
    extraGroups = [ "wheel" "video" "networkmanager" ];
    isNormalUser = true;
  };

  time.timeZone = "Asia/Jakarta";
}
