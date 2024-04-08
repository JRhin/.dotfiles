{...}:
{
  # Enable the ClamAV service and keep the database up to date
  services.clamav = {
    daemon.enable = true;
    updater.enable = true;
  };
}
