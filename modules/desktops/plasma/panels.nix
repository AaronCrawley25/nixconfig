{ self, inputs, ... }: {
  flake.nixosModules.plasma = { pkgs, lib, ... }: {
    home.programs.plasma = {
      # Panels
    };
  };
}
