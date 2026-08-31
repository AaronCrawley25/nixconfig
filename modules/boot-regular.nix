{ self, inputs, ... }: {
  flake.nixosModules.bootRegular = { pkgs, lib, ... }: {
    boot.loader.systemd-boot.enable = true;
  };
}
