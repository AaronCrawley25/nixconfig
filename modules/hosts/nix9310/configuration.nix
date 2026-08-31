{ self, inputs, ... }:
{
  flake.nixosModules.nix9310 =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    let
      howdyServices = [
        "sudo"
        "hyprlock"
      ];
    in
    {
      # Use latest kernel.
      boot.kernelPackages = pkgs.linuxPackages_latest;

      hardware.bluetooth.enable = true;

      zramSwap = {
        enable = true;
        memoryPercent = 25;
      };

      services.logind.settings.Login = {
        HandleLidSwitchDocked = "ignore";
      };

      # Force disable fingerprint as it doesn't work on this model
      services.fprintd.enable = lib.mkForce false;

      # Enable face sign in
      # Configure with `sudo howdy add`
      services.howdy = {
        enable = true;
        control = "sufficient";
        # settings = {
        #   core = {
        #     workaround = "input";
        #   };
        # };
      };

      security.pam.howdy.enable = true;

      security.pam.services = lib.genAttrs howdyServices (svc: {
        rules.auth.howdy.order = config.security.pam.services.${svc}.rules.auth.unix.order + 10;
      });

      # Configure with `sudo linux-enable-ir-emitter configure`
      services.linux-enable-ir-emitter.enable = true;

      # Workaround since touchscreen appears to be default
      home = {
        services.bezel.config = {
          device = {
            path = "/dev/input/by-path/pci-0000:00:15.1-platform-i2c_designware.1-event-mouse";
          };
        };
      };

      system.stateVersion = "25.11";
    };
}
