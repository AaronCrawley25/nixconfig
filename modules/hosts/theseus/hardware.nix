{ self, inputs, ... }: {
  flake.nixosModules.theseus =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      # Put the generated hardware config here
    };
}
