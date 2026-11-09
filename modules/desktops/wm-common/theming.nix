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
        papirus-icon-theme
        (pkgs.papirus-folders.overrideAttrs (old: {
          nativeBuildInputs = (old.nativeBuildInputs or [ ]) ++ [ pkgs.makeWrapper ];
          postFixup = (old.postFixup or "") + ''
            wrapProgram $out/bin/papirus-folders \
              --prefix PATH : ${pkgs.lib.makeBinPath [ pkgs.gtk3 ]}
          '';
        }))
        # gnome-icon-theme
      ];

      gtk.iconCache.enable = true;

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
            name = "CaskaydiaCove NF";
            size = 11;
          };
          iconTheme = {
            name = "Papirus";
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
          platformTheme.name = "qtct";
          style.name = "adwaita-dark";

          qt6ctSettings = {
            Appearance = {
              style = "Adwaita-Dark";
              icon_theme = "Papirus";
              custom_palette = true;
              color_scheme_path = "${
                config.home-manager.users.${username}.xdg.configHome
              }/qt6ct/colors/noctalia.conf";
            };
            Fonts = {
              fixed = "\"CaskaydiaCove NFM,11\"";
              general = "\"CaskaydiaCove NF,11\"";
            };
          };
        };
      };

    };
}
