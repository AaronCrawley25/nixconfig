{ self, inputs, ... }: {
  flake.nixosModules.base = { hostname, ... }: {
    networking = {
      networkmanager.enable = true;
      hostName = hostname;
    };
  };
}
