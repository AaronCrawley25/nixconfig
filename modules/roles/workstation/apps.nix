{ self, inputs, ... }: {
  flake.nixosModules.workstation =
    {
      pkgs,
      lib,
      username,
      ...
    }:
    {
      environment.systemPackages = with pkgs; [
        inputs.nixvim-config.packages.${stdenv.hostPlatform.system}.default
        spotify
        xdg-user-dirs
        playerctl
        cava
        bitwarden-desktop
      ];

      environment.sessionVariables = {
        EDITOR = lib.mkOverride 900 "nvim";
        SSH_AUTH_SOCK = "/home/${username}/.bitwarden-ssh-agent.sock";
      };

      programs = {
        firefox.enable = true;
        kdeconnect.enable = true;
      };

      services = {
        udisks2.enable = true;
        upower.enable = true;
        avahi.enable = true;
        automatic-timezoned.enable = true;
      };

      home = {
        programs.discord = {
          enable = true;
          settings.SKIP_HOST_UPDATE = true;
        };
      };
    };
}
