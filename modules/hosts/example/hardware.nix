{ self, inputs, ... }: {
  flake.nixosModules.example = { pkgs, lib, config, ... }: {
    # Put the generated hardware config here
  };
}
