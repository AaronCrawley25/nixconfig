{ self, inputs, ... }: {
  flake.nixosModules.workstation = { pkgs, lib, ... }: {
    environment.systemPackages = with pkgs; [
      inputs.nixvim-config.packages.${stdenv.hostPlatform.system}.default
      spotify
      xdg-user-dirs
      playerctl
    ];

    environment.sessionVariables.EDITOR = lib.mkOverride 900 "nvim";

    programs = {
      firefox.enable = true;
      kdeconnect.enable = true;
    };

    services = {
      udisks2.enable = true;
      upower.enable = true;
    };

    home = {
      programs.discord = {
        enable = true;
        settings.SKIP_HOST_UPDATE = true;
      };
    };
  };
}
