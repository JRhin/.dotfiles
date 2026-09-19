{ ... }:

{
  # Compressed swap in RAM, used before your disk swap (higher priority)
  zramSwap.enable = true;

  # Kills the heaviest process before the system freezes on low memory
  services.earlyoom.enable = true;
}
