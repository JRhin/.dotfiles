{ ... }:

{
  # Keep the signature database updated; scan on demand with `clamscan`
  services.clamav.updater.enable = true;
}
