{ self, inputs, ... }: {
  flake.nixosModules.wm-common =
    {
      pkgs,
      lib,
      config,
      username,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        adwaita-icon-theme
        # gnome-icon-theme
      ];

      home = {
        dconf.settings = {
          "org/gnome/desktop/interface" = {
            color-scheme = "prefer-dark";
            gtk-theme = "Adwaita-dark";
          };
          "org/gnome/desktop/wm/preferences" = {
            button-layout = "appmenu:minimize,maximize,close";
          };
        };

        gtk = {
          enable = true;
          theme = {
            name = "Adwaita-dark";
            package = pkgs.gnome-themes-extra;
          };
          font = {
            name = "CaskaydiaCove NFM";
            size = 11;
          };
          iconTheme = {
            name = "Adwaita";
          };
          gtk3.extraConfig = {
            gtk-application-prefer-dark-theme = true;
          };
          gtk4 = {
            enable = true;
            theme = config.home-manager.users.${username}.gtk.theme;
            extraConfig = {
              gtk-application-prefer-dark-theme = true;
            };
          };
        };

        qt = {
          enable = true;
          platformTheme.name = "adwaita";
          style.name = "adwaita-dark";
        };
      };

    };
}
