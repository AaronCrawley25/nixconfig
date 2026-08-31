{ self, inputs, ... }: {
  flake.nixosModules.workstation = { pkgs, lib, ... }: {
    fonts.packages = with pkgs; [
      nerd-fonts.caskaydia-mono
      nerd-fonts.caskaydia-cove
      corefonts
      vista-fonts
    ];
  };
}
