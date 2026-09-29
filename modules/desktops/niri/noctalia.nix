{ self, inputs, ... }:
{
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    home = {
      imports = [
        inputs.noctalia.homeModules.default
      ];

      programs.noctalia = {
        enable = true;
        systemd.enable = true;

        settings = {
          theme = {
            mode = "dark";
            shell_mode = "follow";
            source = "wallpaper";

            templates = {
              enable_builtin_templates = true;
              builtin_ids = [
                "kitty"
                "niri"
                "gtk3"
                "gtk4"
                "qt"
                "btop"
              ];
            };
          };

          shell = {
            font_family = "CaskaydiaCove NF";
            launcher.compact = true;
            polkit_agent = true;
            niri_overview_type_to_launch_enabled = true;

            panel = {
              launcher_placement = "attached";
              clipboard_placement = "attached";
              polkit_placement = "attached";
            };
          };

          bar.default = {
            margin_ends = 8;
            margin_edge = 8;
            font_family = "CaskaydiaCove NF";
            font_scale = 0.95;
            widget_spacing = 8;
            capsule = true;
            capsule_padding = 10;

            start = [
              "launcher"
              "taskbar"
              "active_window"
            ];
            center = [
              "privacy"
            ];
            end = [
              "tray"
              "media"
              "battery"
              "network"
              "bluetooth"
              "notifications"
              "volume"
              "clock"
              "control-center"
              "session"
            ];
          };

          widget = {
            taskbar = {
              only_active_workspace = true;
            };

            launcher.glyph = "snowflake";

            active_window = {
              display = "text_only";
            };

            clock.format = " {:%-H:%M %p}";

            control-center.glyph = "settings";

            privacy.hide_inactive = true;
          };

          location = {
            enabled = true;
            auto_locate = true;
          };

          nightlight = {
            enabled = true;
          };

          notification = {
            position = "bottom_right";
            offset_x = 12;
            offset_y = 12;
          };

          wallpaper.directory = "~/Pictures/Wallpapers";
        };
      };

      programs.kitty.extraConfig = "include themes/noctalia.conf";
    };
  };
}
