{ self, inputs, ... }:
{
  flake.nixosModules.theseus =
    {
      pkgs,
      lib,
      username,
      ...
    }:
    {
      boot.kernelPackages = pkgs.linuxPackages_latest;

      hardware.bluetooth.enable = true;

      zramSwap = {
        enable = true;
        memoryPercent = 25;
      };

      services.logind.settings.Login = {
        HandleLidSwitchDocked = "ignore";
      };

      programs.silentSDDM.enable = lib.mkForce false;

      services.displayManager.noctalia-greeter = {
        enable = true;
        settings = {
          cursor.size = 24;
          keyboard.layout = "us";
          appearance.hide_logo = true;
          auth.allow_empty_password = true;
        };
        cursorTheme = {
          name = "Adwaita";
        };
        passwordlessSyncUsers = [ "${username}" ];
      };

      boot.loader.systemd-boot.consoleMode = "0";

      # Workaround since touchscreen appears to be default
      home = {
        services.bezel.config = {
          device = {
            path = "PIXA3854:00 093A:1343 Touchpad";
          };
        };

        services.easyeffects = {
          enable = true;
          extraPresets.framework-speakers = builtins.fromJSON (builtins.readFile ./easyeffects.json);
          preset.output = "framework-speakers";
        };
      };

      imports = [ inputs.nix-framework-fingerprint-led-blink.nixosModules.default ];
      services.framework-fingerprint-led-blink = {
        enable = true;
        onSeconds = 0.1;
        offSeconds = 0.1;
      };

      system.stateVersion = "26.05";
    };
}
