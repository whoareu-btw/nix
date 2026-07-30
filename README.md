# nix

All my nix configuration, with flakes and home-manager

NOTE: `rikka` is environment directory and `hanabi` is home-manager directory

## If you want to use xorg:
Change this at `rika/env/default.nix`
```nix
{
  imports = [
    ./sway/default.nix # comment this line with `#`
    ./xorg/default.nix
  ];
}
```

## Difference between `sway.nix` and `xorg.nix`
    `sway.nix` uses sway (like it's file name) as window manager and ly as display manager.
    `xorg.nix` uses mate as desktop manager and lightdm as display manager.
