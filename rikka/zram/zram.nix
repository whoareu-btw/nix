{ lib, ... }:

{
  zramSwap = {
    enable = true;
    priority = 80;
    algorithm = "lz4";
    memoryPercent = 50;
  };
}
