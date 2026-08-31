{ self, inputs, ... }: {
  flake.nixosConfigurations.nix9310 = inputs.self.lib.mkHost {
    hostname = "nix9310";
    username = "aaron";
    gitname = "Aaron Crawley";
    gitemail = "aaron.crawley@outlook.com.au";
    modules = [
      inputs.nixos-hardware.nixosModules.dell-xps-13-9310
      self.nixosModules.bootSecure
      self.nixosModules.workstation
      self.nixosModules.homelab
      self.nixosModules.niri
    ];
  };
}
