{ self, inputs, ... }: {
  flake.nixosModules.k3s-agent = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.k3s-common
    ];

    services.k3s = {
      role = "agent";
    };
  };
}
