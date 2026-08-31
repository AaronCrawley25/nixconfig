{ self, inputs, ... }: {
  flake.nixosModules.gaming = { pkgs, lib, ... }: {
    environment.systemPackages = with pkgs; [
      prismlauncher
      mangohud
      dolphin-emu
      wheelwizard

      (heroic.override {
        extraPkgs =
          pkgs': with pkgs'; [
            gamescope
            gamemode
          ];
      })
    ];

    programs.gamemode.enable = true;
    programs.gamescope.enable = true;

    programs.steam = {
      enable = true;

      gamescopeSession.enable = true;

      remotePlay.openFirewall = true;
      localNetworkGameTransfers.openFirewall = true;
      # dedicatedServer.openFirewall = true;

      extraCompatPackages = with pkgs; [
        proton-ge-bin
      ];
    };

    hardware.xpadneo.enable = true;
  };
}
