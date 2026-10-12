{ self, inputs, ... }: {
  flake.nixosModules.workstation = { pkgs, lib, ... }: {
    services.printing = {
      enable = true;
      cups-pdf.enable = true;
    };
  };
}
