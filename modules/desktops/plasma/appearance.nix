{ self, inputs, ... }: {
  flake.nixosModules.plasma = { pkgs, lib, ... }: {
    home.programs.plasma = {
      workspace = {
        lookAndFeel = "org.kde.breezedark.desktop";
      };

      fonts = {
        general = {
          family = "CaskaydiaCove NF";
          pointSize = 10;
        };
        fixedWidth = {
          family = "CaskaydiaCove NFM";
          pointSize = 10;
        };
        small = {
          family = "CaskaydiaCove NF";
          pointSize = 8;
        };
        toolbar = {
          family = "CaskaydiaCove NF";
          pointSize = 10;
        };
        menu = {
          family = "CaskaydiaCove NF";
          pointSize = 10;
        };
        windowTitle = {
          family = "CaskaydiaCove NF";
          pointSize = 10;
        };
      };
    };
  };
}
