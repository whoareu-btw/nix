{ lib, ... }:

{
  services.libinput = {
    enable = true;
    touchpad = {
      disableWhileTyping = true;
      tapping = true;
      scrollMethod = "twofinger";
      naturalScrolling = true;
    };
  };
}
