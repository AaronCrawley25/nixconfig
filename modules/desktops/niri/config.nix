{ self, inputs, ... }:
{
  flake.nixosModules.niri = { pkgs, lib, ... }: {
    home = {
      wayland.windowManager.niri = {
        enable = true;

        # noctalia.kdl doesn't exist during build, don't check config
        checkConfig = false;

        settings = {
          input = {
            keyboard = {
              xkb.options = "caps:escape_shifted_capslock";
              numlock = { };
            };
            touchpad = {
              tap = { };
              natural-scroll = { };
            };
            mouse = { };
            trackpoint = { };
            warp-mouse-to-focus = { };
            focus-follows-mouse._props.max-scroll-amount = "0%";
          };

          cursor = {
            xcursor-theme = "Adwaita";
            xcursor-size = 26;
          };

          layout = {
            gaps = 8;
            background-color = "transparent";
            center-focused-column = "never";
            preset-column-widths._children = [
              { proportion = 0.33333; }
              { proportion = 0.5; }
              { proportion = 0.66667; }
            ];
            default-column-width.proportion = 1.0;
            focus-ring.off = { };
            border = {
              on = { };
              width = 3;
            };
            shadow = { };
          };

          overview.workspace-shadow.off = { };

          hotkey-overlay.skip-at-startup = { };

          prefer-no-csd = { };

          screenshot-path = "~/Pictures/Screenshots/Screenshot from %Y-%m-%d %H-%M-%S.png";

          animations = { };

          gestures.hot-corners.off = { };

          debug.honor-xdg-activation-with-invalid-serial = { };

          _children = [
            # match all windows
            {
              window-rule = {
                geometry-corner-radius = 6;
                clip-to-geometry = true;
                draw-border-with-background = false;
              };
            }
            # firefox pip floating
            {
              window-rule = {
                match._props = {
                  app-id = "firefox$";
                  title = "^Picture-in-Picture$";
                };
                open-floating = true;
                default-floating-position._props = {
                  x = 10;
                  y = 10;
                  relative-to = "bottom-right";
                };
              };
            }
            # calculator floating
            {
              window-rule = {
                match._props.app-id = "org.gnome.Calculator$";
                open-floating = true;
                default-floating-position._props = {
                  x = 10;
                  y = 0;
                  relative-to = "right";
                };
              };
            }
            { workspace._args = [ "spotify" ]; }
            {
              window-rule = {
                match._props.app-id = "^Spotify$";
                open-on-workspace = "spotify";
              };
            }
            # wallpaper in overview backdrop
            {
              layer-rule = {
                match._props.namespace = "^noctalia-wallpaper";
                place-within-backdrop = true;
              };
            }
          ];

          binds = {
            "Mod+Shift+Slash".show-hotkey-overlay = { };

            "Mod+Q" = {
              _props.hotkey-overlay-title = "Open a Terminal: kitty";
              spawn = [ "kitty" ];
            };
            "Mod+Return" = {
              _props.hotkey-overlay-title = "Open a Browser: firefox";
              spawn = [ "firefox" ];
            };
            "Mod+R" = {
              _props.hotkey-overlay-title = "Open Noctalia launcher";
              spawn-sh = "noctalia msg panel-toggle launcher";
            };
            "Mod+X" = {
              _props.hotkey-overlay-title = "Open Noctalia power menu";
              spawn-sh = "noctalia msg panel-toggle session";
            };
            "Mod+I" = {
              _props.hotkey-overlay-title = "Open Noctalia settings menu";
              spawn-sh = "noctalia msg panel-toggle control-center";
            };
            "Mod+V" = {
              _props.hotkey-overlay-title = "Open Noctalia settings menu";
              spawn-sh = "noctalia msg panel-toggle clipboard";
            };
            "Mod+A" = {
              _props.hotkey-overlay-title = "Open Noctalia notifications";
              spawn-sh = "noctalia msg panel-toggle notification";
            };
            "Mod+Period".spawn-sh = "noctalia msg panel-toggle launcher /emo";
            "Mod+Semicolon".spawn-sh = "noctalia msg panel-toggle noctalia/notes:panel";
            "Mod+Slash".spawn-sh = "noctalia msg panel-toggle launcher /";
            "Mod+N" = {
              _props.hotkey-overlay-title = "Open Neovim";
              spawn = [
                "kitty"
                "nvim"
              ];
            };
            "Mod+E" = {
              _props.hotkey-overlay-title = "Open Nautilus";
              spawn = [ "nautilus" ];
            };

            "XF86AudioRaiseVolume" = {
              _props.allow-when-locked = true;
              spawn-sh = "noctalia msg volume-up 5";
            };
            "XF86AudioLowerVolume" = {
              _props.allow-when-locked = true;
              spawn-sh = "noctalia msg volume-down 5";
            };
            "XF86AudioMute" = {
              _props.allow-when-locked = true;
              spawn-sh = "noctalia msg volume-mute";
            };
            "XF86AudioMicMute" = {
              _props.allow-when-locked = true;
              spawn-sh = "noctalia msg mic-mute";
            };

            "XF86AudioPlay" = {
              _props.allow-when-locked = true;
              spawn-sh = "playerctl play-pause";
            };
            "XF86AudioStop" = {
              _props.allow-when-locked = true;
              spawn-sh = "playerctl stop";
            };
            "XF86AudioPrev" = {
              _props.allow-when-locked = true;
              spawn-sh = "playerctl previous";
            };
            "XF86AudioNext" = {
              _props.allow-when-locked = true;
              spawn-sh = "playerctl next";
            };

            "XF86MonBrightnessUp" = {
              _props.allow-when-locked = true;
              spawn = [
                "brightnessctl"
                "--class=backlight"
                "set"
                "+10%"
              ];
            };
            "XF86MonBrightnessDown" = {
              _props.allow-when-locked = true;
              spawn = [
                "brightnessctl"
                "--class=backlight"
                "set"
                "10%-"
              ];
            };

            "Mod+Tab" = {
              _props.repeat = false;
              toggle-overview = { };
            };

            "Mod+C" = {
              _props.repeat = false;
              close-window = { };
            };

            "Mod+Left".focus-column-left = { };
            "Mod+Down".focus-window-down = { };
            "Mod+Up".focus-window-up = { };
            "Mod+Right".focus-column-right = { };
            "Mod+H".focus-column-left = { };
            "Mod+J".focus-window-or-workspace-down = { };
            "Mod+K".focus-window-or-workspace-up = { };
            "Mod+L".focus-column-right = { };

            "Mod+Shift+Left".move-column-left = { };
            "Mod+Shift+Down".move-window-down = { };
            "Mod+Shift+Up".move-window-up = { };
            "Mod+Shift+Right".move-column-right = { };
            "Mod+Shift+H".move-column-left = { };
            "Mod+Shift+J".move-window-down-or-to-workspace-down = { };
            "Mod+Shift+K".move-window-up-or-to-workspace-up = { };
            "Mod+Shift+L".move-column-right = { };

            "Mod+Home".focus-column-first = { };
            "Mod+End".focus-column-last = { };
            "Mod+Shift+Home".move-column-to-first = { };
            "Mod+Shift+End".move-column-to-last = { };

            "Mod+Ctrl+Left".focus-monitor-left = { };
            "Mod+Ctrl+Down".focus-monitor-down = { };
            "Mod+Ctrl+Up".focus-monitor-up = { };
            "Mod+Ctrl+Right".focus-monitor-right = { };
            "Mod+Ctrl+H".focus-monitor-left = { };
            "Mod+Ctrl+J".focus-monitor-down = { };
            "Mod+Ctrl+K".focus-monitor-up = { };
            "Mod+Ctrl+L".focus-monitor-right = { };

            "Mod+Shift+Ctrl+Left".move-workspace-to-monitor-left = { };
            "Mod+Shift+Ctrl+Down".move-workspace-to-monitor-down = { };
            "Mod+Shift+Ctrl+Up".move-workspace-to-monitor-up = { };
            "Mod+Shift+Ctrl+Right".move-workspace-to-monitor-right = { };
            "Mod+Shift+Ctrl+H".move-column-to-monitor-left = { };
            "Mod+Shift+Ctrl+J".move-column-to-monitor-down = { };
            "Mod+Shift+Ctrl+K".move-column-to-monitor-up = { };
            "Mod+Shift+Ctrl+L".move-column-to-monitor-right = { };

            "Mod+Ctrl+Shift+Page_Down".move-workspace-down = { };
            "Mod+Ctrl+Shift+Page_Up".move-workspace-up = { };
            "Mod+Ctrl+Shift+U".move-workspace-down = { };
            "Mod+Ctrl+Shift+I".move-workspace-up = { };

            "Mod+WheelScrollDown" = {
              _props.cooldown-ms = 150;
              focus-workspace-down = { };
            };
            "Mod+WheelScrollUp" = {
              _props.cooldown-ms = 150;
              focus-workspace-up = { };
            };

            "Mod+WheelScrollRight".focus-column-right = { };
            "Mod+WheelScrollLeft".focus-column-left = { };
            "Mod+Ctrl+WheelScrollRight".move-column-right = { };
            "Mod+Ctrl+WheelScrollLeft".move-column-left = { };

            "Mod+Shift+WheelScrollDown".focus-column-right = { };
            "Mod+Shift+WheelScrollUp".focus-column-left = { };
            "Mod+Ctrl+Shift+WheelScrollDown".move-column-right = { };
            "Mod+Ctrl+Shift+WheelScrollUp".move-column-left = { };

            "Mod+TouchpadScrollDown".spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.02+";
            "Mod+TouchpadScrollUp".spawn-sh = "wpctl set-volume @DEFAULT_AUDIO_SINK@ 0.02-";

            "Mod+1".focus-workspace = 1;
            "Mod+2".focus-workspace = 2;
            "Mod+3".focus-workspace = 3;
            "Mod+4".focus-workspace = 4;
            "Mod+5".focus-workspace = 5;
            "Mod+6".focus-workspace = 6;
            "Mod+7".focus-workspace = 7;
            "Mod+8".focus-workspace = 8;
            "Mod+9".focus-workspace = 9;
            "Mod+Shift+1".move-column-to-workspace = 1;
            "Mod+Shift+2".move-column-to-workspace = 2;
            "Mod+Shift+3".move-column-to-workspace = 3;
            "Mod+Shift+4".move-column-to-workspace = 4;
            "Mod+Shift+5".move-column-to-workspace = 5;
            "Mod+Shift+6".move-column-to-workspace = 6;
            "Mod+Shift+7".move-column-to-workspace = 7;
            "Mod+Shift+8".move-column-to-workspace = 8;
            "Mod+Shift+9".move-column-to-workspace = 9;

            "Mod+BracketLeft".consume-or-expel-window-left = { };
            "Mod+BracketRight".consume-or-expel-window-right = { };

            "Mod+Comma".set-column-width = "50%";
            "Mod+Shift+Period".expand-column-to-available-width = { };

            "Mod+Ctrl+Shift+R".switch-preset-window-height = { };
            "Mod+Ctrl+R".reset-window-height = { };

            "Mod+M".maximize-column = { };
            "Mod+F".fullscreen-window = { };

            "Mod+Ctrl+C".center-visible-columns = { };

            "Mod+Alt+H".set-column-width = "-10%";
            "Mod+Alt+L".set-column-width = "+10%";
            "Mod+Alt+K".set-window-height = "-10%";
            "Mod+Alt+J".set-window-height = "+10%";

            "Mod+W".toggle-column-tabbed-display = { };

            "Print".screenshot = { };
            "Mod+Shift+S".screenshot = { };
            "Ctrl+Print".screenshot-screen = { };
            "Alt+Print".screenshot-window = { };

            "Mod+Escape" = {
              _props.allow-inhibiting = false;
              toggle-keyboard-shortcuts-inhibit = { };
            };

            "Mod+Shift+E".quit = { };
            "Ctrl+Alt+Delete".quit = { };

            "Mod+Shift+P".power-off-monitors = { };
          };
        };

        # appended after generated config
        extraConfig = ''
          include "noctalia.kdl"
        '';
      };

    };
  };
}
