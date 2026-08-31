{ self, inputs, ... }: {
  flake.nixosModules.workstation = { pkgs, lib, ... }: {
    environment.systemPackages = with pkgs; [
      kitty
    ];

    environment.sessionVariables = {
      TERMINAL = "${pkgs.kitty}";
    };

    home = {
      programs.kitty = {
        enable = true;

        font = {
          name = "CaskaydiaCove NFM";
        };

        settings = {
          bold_font = "auto";
          italic_font = "auto";
          bold_italic_font = "auto";
          background_opacity = 0.8;
          window_padding_width = 10;
          confirm_os_window_close = 0;
          cursor_shape = "beam";
          enable_audio_bell = "no";
        };

        keybindings = {
          "ctrl+shift+v" = "paste_from_clipboard";
          "ctrl+shift+c" = "copy_to_clipboard";
          "ctrl+shift+left" = "no_op";
          "ctrl+shift+right" = "no_op";
          "ctrl+shift+home" = "no_op";
          "ctrl+shift+end" = "no_op";
          "ctrl+shift+equal" = "change_font_size all +1.0";
          "ctrl+shift+plus" = "change_font_size all +1.0";
          "ctrl+shift+kp_add" = "change_font_size all +1.0";
          "cmd+plus" = "change_font_size all +1.0";
          "cmd+equal" = "change_font_size all +1.0";
          "shift+cmd+equal" = "change_font_size all +1.0";
          "ctrl+shift+minus" = "change_font_size all -1.0";
          "ctrl+shift+kp_subtract" = "change_font_size all -1.0";
          "cmd+minus" = "change_font_size all -1.0";
          "shift+cmd+minus" = "change_font_size all -1.0";
        };
      };

    };
  };
}
