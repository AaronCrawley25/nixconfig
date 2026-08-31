{ self, inputs, ... }: {
  flake.nixosModules.base = {
    nixpkgs.config.allowUnfree = true;

    nix.settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];
      substituters = [
        "https://attic.xuyh0120.win/lantian"
        "https://nixos-raspberrypi.cachix.org"
        "https://crawleynix.cachix.org"
      ];
      trusted-public-keys = [
        "lantian:EeAUQ+W+6r7EtwnmYjeVwx5kOGEBpjlBfPlzGlTNvHc="
        "nixos-raspberrypi.cachix.org-1:4iMO9LXa8BqhU+Rpg6LQKiGa2lsNh/j2oiYLNOQ5sPI="
        "crawleynix.cachix.org-1:ya3CVeV/ZN/ZnoXjy0RkhK4Yet3cVQwn3JUEvKWaQZw="
      ];
    };
  };
}
