{ ... }:

{
  # Without this PAM service, swaylock cannot verify your password.
  # The package itself comes from Home Manager, so it is not installed here.
  security.pam.services.swaylock = {};
}
