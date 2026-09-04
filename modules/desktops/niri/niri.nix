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
      programs = {
        quickshell = {
          enable = true;
          systemd.enable = true;
          package = self.packages."x86_64-linux".quickshell-niri;
          activeConfig = "new";
        };
      };
      services = {
        cliphist = {
          enable = true;
          allowImages = true;
        };

        gammastep = {
          enable = true;
          provider = "geoclue2";
          temperature = {
            day = 6500;
            night = 4000;
          };
        };

        udiskie.enable = true;

        polkit-gnome.enable = true;

        awww.enable = true;

        kanshi.enable = true;

        # swayidle.enable = true;
        # swaylock.enable = true;
      };
    };
  };
}
