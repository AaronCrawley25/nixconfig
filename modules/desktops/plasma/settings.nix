{ self, inputs, ... }: {
  flake.nixosModules.plasma = { pkgs, lib, ... }: {
    home.programs.plasma = {
      kwin = {
        edgeBarrier = 0;
        cornerBarrier = false;
      };

      # Maybe move this to host specific or make desktop role?
      kscreenlocker = {
        lockOnResume = true;
        timeout = 30;
        passwordRequiredDelay = 5;
      };

      input.keyboard.options = [
        "caps:escape_shifted_capslock"
      ];

      configFile = {
        kdeglobals."General"."TerminalApplication" = "${pkgs.kitty}";
      };
    };
  };
}
