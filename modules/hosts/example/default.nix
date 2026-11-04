{ self, inputs, ... }: {
  flake.nixosConfigurations.example = inputs.self.lib.mkHost {
    hostname = "example";
    username = "example";
    gitname = "Example";
    gitemail = "example@example.com";
    modules = [
      self.nixosModules.bootRegular
      self.nixosModules.workstation
    ];
  };
}
