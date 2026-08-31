{ self, inputs, ... }: {
  flake.nixosConfigurations.gamerbox = inputs.self.lib.mkHost {
    hostname = "gamerbox";
    username = "aaron";
    gitname = "Aaron Crawley";
    gitemail = "aaron.crawley@outlook.com.au";
    modules = [
      inputs.nixos-hardware.nixosModules.common-cpu-intel-cpu-only
      inputs.nixos-hardware.nixosModules.common-gpu-nvidia-nonprime
      inputs.nixos-hardware.nixosModules.common-pc-ssd
      self.nixosModules.bootSecure
      self.nixosModules.workstation
      self.nixosModules.gaming
      self.nixosModules.plasma
    ];
  };
}
