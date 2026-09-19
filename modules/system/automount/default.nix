{ ... }:

{
  # USB drives and other removable media
  services.udisks2.enable = true;

  # Trash support and MTP (phones) for file choosers
  services.gvfs.enable = true;
}
