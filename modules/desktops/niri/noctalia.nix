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
            polkit_agent = true;
            niri_overview_type_to_launch_enabled = true;
            greeter_sync.auto_sync = true;

            launcher = {
              compact = true;

              dmenu.entry.ssh = {
                command = ''
                  grep -v '^|1|' ~/.ssh/known_hosts | cut -d' ' -f1 | tr ',' '\n' \
                    | sed -E 's/^\[([^]]+)\]:[0-9]+$/\1/' \
                    | grep -Ev '^([0-9]{1,3}\.){3}[0-9]{1,3}$|:' \
                    | sort -u
                '';
                exec = "kitty kitten ssh {selection}";
                prefix = "ssh";
                glyph = "server";
                global = false;
              };
            };

            panel = {
              launcher_placement = "attached";
              clipboard_placement = "attached";
              polkit_placement = "attached";
              open_near_click_control_center = true;
              open_near_click_launcher = true;
              open_near_click_clipboard = true;
              open_near_click_wallpaper = true;
              open_near_click_session = true;
            };
          };

          bar.default = {
            margin_ends = 8;
            margin_edge = 8;
            font_family = "CaskaydiaCove NF";
            font_scale = 0.95;
            widget_spacing = 6;
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
              show_empty_label = true;
              min_length = 0;
              max_length = 400;
              title_scroll = "on_hover";
            };

            clock.format = " {:%-H:%M %p}";

            control-center.glyph = "settings";

            privacy.hide_inactive = true;

            media = {
              hide_when_no_media = true;
              max_length = 300;
              title_scroll = "on_hover";
            };
          };

          location = {
            auto_locate = true;
          };

          nightlight = {
            enabled = true;
          };

          notification = {
            position = "top_center";
            # position = "bottom_right";
            # offset_x = 16;
            offset_y = 16;
            follow_focused_output = true;
          };

          wallpaper.directory = "~/Pictures/Wallpapers";

          idle = {
            behavior = {
              behavior_order = [
                "lock"
                "screen-off"
                "suspend"
              ];

              pre_action_fade_seconds = 2.0;

              lock = {
                timeout = 600;
                action = "lock";
                enabled = true;
              };

              screen-off = {
                timeout = 660;
                action = "screen_off";
                enabled = true;
              };

              suspend = {
                timeout = 900;
                action = "lock_and_suspend";
                enabled = true;
              };
            };
          };

          osd = {
            offset_y = 16;
          };

          desktop_widgets.enabled = false;

          # TODO: re-enable when dock opens new instead of raise
          # dock = {
          #   enabled = true;
          #   auto_hide = false;
          #   smart_auto_hide = true;
          #   reserve_space = false;
          #   show_running = false;
          #   show_instance_count = false;
          #   pinned = [
          #     "firefox"
          #     "kitty"
          #     "nvim"
          #   ];
          # };

          plugins = {
            enabled = [
              "noctalia/notes"
            ];
          };
        };
      };

      programs.kitty.extraConfig = "include themes/noctalia.conf";
    };
  };
}
