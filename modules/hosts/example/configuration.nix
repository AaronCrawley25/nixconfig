{ self, inputs, ... }:
{
  flake.nixosModules.example =
    { pkgs, lib, ... }:
    {
      boot.kernelPackages = pkgs.linuxPackages_latest;
      system.stateVersion = "26.05";
    };
}
