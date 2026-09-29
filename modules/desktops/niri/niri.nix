{ self, inputs, ... }:
{
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.wm-common
    ];

    environment.systemPackages = with pkgs; [
      xwayland-satellite
    ];

    programs = {
      niri.enable = true;
    };

    services = {
      gnome.gnome-keyring.enable = false;
      geoclue2.enable = true;
    };

    xdg.portal.extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];

    hardware.acpilight.enable = true;

    home = {
      services = {
        udiskie.enable = true;
      };
    };
  };
}
