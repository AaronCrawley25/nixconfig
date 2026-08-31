{ self, inputs, ... }: {
  flake.nixosModules.base = {
    networking.firewall.enable = true;
    networking.firewall.allowedTCPPorts = [ ];
    networking.firewall.allowedUDPPorts = [ ];
  };
}
