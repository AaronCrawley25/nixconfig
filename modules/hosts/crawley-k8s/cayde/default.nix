{ self, inputs, ... }: {
  flake.nixosConfigurations.cayde = inputs.self.lib.mkHost {
    hostname = "cayde";
    username = "aaron";
    gitname = "Aaron Crawley";
    gitemail = "aaron.crawley@outlook.com.au";
    sshkey = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOXLV0PizNxq9zg65o2/1HnYwbLEeyXm7MFBK83D8Aue aaron@arch9310";
    modules = [
      self.nixosModules.server
      self.nixosModules.k3s-server
      self.nixosModules.raspberry-pi
    ];
  };
}
