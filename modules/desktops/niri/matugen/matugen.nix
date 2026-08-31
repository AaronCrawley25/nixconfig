{ self, inputs, ... }: {
  flake.nixosModules.niri =
    {
      pkgs,
      lib,
      username,
      ...
    }:
    {
      home = {
        home.packages = with pkgs; [
          matugen

          (pkgs.writeShellScriptBin "matugen-gtk-colors" ''
            #!/usr/bin/env bash

            current=$(gsettings get org.gnome.desktop.interface color-scheme)

            if [[ "$current" == "'prefer-dark'" ]]; then
                dconf write /org/gnome/desktop/interface/color-scheme '"prefer-light"'
                dconf write /org/gnome/desktop/interface/color-scheme '"prefer-dark"'
            else
                dconf write /org/gnome/desktop/interface/color-scheme '"prefer-dark"'
                dconf write /org/gnome/desktop/interface/color-scheme '"prefer-light"'
            fi
          '')
        ];

        xdg.configFile = {
          "matugen/config.toml".text = ''
            [config]
            [config.wallpaper]
            set = true
            command = "awww img {{ image }} --transition-type wipe"

            [templates.kitty]
            input_path = '${builtins.toString ./templates/kitty-colors.conf}'
            output_path = '~/.config/kitty/Matugen.conf'
            post_hook = "pkill -SIGUSR1 kitty"

            [templates.gtk3]
            input_path = '${builtins.toString ./templates/gtk-colors.css}'
            output_path = '~/.config/gtk-3.0/colors.css'

            [templates.gtk4]
            input_path = '${builtins.toString ./templates/gtk-colors.css}'
            output_path = '~/.config/gtk-4.0/colors.css'

            [templates.neovim]
            input_path = "${builtins.toString ./templates/nvim-colors.json}"
            output_path = "~/.config/matugen/themes/nvim-colors.json"
            post_hook = "pkill -SIGUSR1 nvim"

            [templates.niri]
            input_path = '${builtins.toString ./templates/niri-colors.kdl}'
            output_path = '~/.config/niri/colors.kdl'
            post_hook = 'niri msg action load-config-file'

            [templates.quickshell]
            input_path = '${builtins.toString ./templates/quickshell.json}'
            output_path = '~/.local/state/quickshell/generated/colors.json'
          '';
        };

        programs.kitty.extraConfig = "include Matugen.conf";

        gtk = {
          gtk4.extraCss = "@import 'colors.css';";
          gtk3.extraCss = "@import 'colors.css';";
        };
      };
    };
}
