{ ... }:

{
  services.tlp = {
    enable = true;
    settings = {
      # Profile
      TLP_PROFILE_AC = "BAL";
      TLP_PROFILE_BAT = "SAV";

      # CPU
      CPU_SCALING_GOVERNOR_ON_AC = "performance";
      CPU_ENERGY_PERF_POLICY_ON_AC = "performance";

      CPU_SCALING_GOVERNOR_ON_BAT = "powersave";
      CPU_ENERGY_PERF_POLICY_ON_BAT = "power";

      CPU_MIN_PERF_ON_AC = 0;
      CPU_MAX_PERF_ON_AC = 100;

      CPU_MIN_PERF_ON_BAT = 0;
      CPU_MAX_PERF_ON_BAT = 80;

      # USB
      USB_AUTOSUSPEND = 1;
      USB_EXCLUDE_AUDIO = 1;
    };
  };
}
