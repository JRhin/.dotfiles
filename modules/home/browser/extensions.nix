{ inputs }:

# Shared by Firefox and Zen
with inputs.firefox-addons.packages."x86_64-linux"; [
  adblocker-ultimate
  multi-account-containers
  proton-pass
  proton-vpn
]
