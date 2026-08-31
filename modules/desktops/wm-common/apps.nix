{ self, inputs, ... }: {
  flake.nixosModules.wm-common = { pkgs, lib, ... }: {
    environment.systemPackages = with pkgs; [
      adwaita-icon-theme
      nautilus
      gnome-calculator
      snapshot
      file-roller
      eog
    ];
  };
}
