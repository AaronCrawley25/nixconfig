{ self, inputs, ... }: {
  flake.nixosConfigurations.theseus = inputs.self.lib.mkHost {
    hostname = "theseus";
    username = "aaron";
    gitname = "Aaron Crawley";
    gitemail = "aaron.crawley@outlook.com.au";
    modules = [
      inputs.nixos-hardware.nixosModules.framework-intel-core-ultra-series3
      self.nixosModules.bootRegular
      self.nixosModules.workstation
      self.nixosModules.homelab
      self.nixosModules.niri
    ];
  };
}
