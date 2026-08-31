{ self, inputs, ... }: {
  flake.nixosModules.plasma = { pkgs, lib, ... }: {
    home.imports = [
      inputs.plasma-manager.homeModules.plasma-manager
    ];

    services.desktopManager.plasma6.enable = true;

    environment = {
      plasma6.excludePackages = with pkgs.kdePackages; [
        konsole
        elisa
        kate
        ktexteditor
      ];

      systemPackages = with pkgs.kdePackages; [
        partitionmanager
      ];
    };

    home.programs.plasma = {
      enable = true;
      # overrideConfig = true;
    };

    home.programs = {
      elisa.enable = false;
      kate.enable = false;
      konsole.enable = false;
    };
  };
}
