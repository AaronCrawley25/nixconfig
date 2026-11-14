{ self, inputs, ... }: {
  flake.nixosModules.base = {
    nixpkgs.config.allowUnfree = true;

    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://nixos-raspberrypi.cachix.org"
        "https://crawleynix.cachix.org"
        "https://noctalia.cachix.org"
        "https://nix-community.cachix.org"
      ];
      trusted-public-keys = [
        "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
        "crawleynix.cachix.org-1:ya3CVeV/ZN/ZnoXjy0RkhK4Yet3cVQwn3JUEvKWaQZw="
        "noctalia.cachix.org-1:pCOR47nnMEo5thcxNDtzWpOxNFQsBRglJzxWPp3dkU4="
        "nix-community.cachix.org-1:mB9FSh9qf2dCimDSUo8Zy7bkq5CX+/rkCWyvRCYg3Fs="
      ];
    };

    system.configurationRevision = self.rev or self.dirtyRev or null;
  };
}
