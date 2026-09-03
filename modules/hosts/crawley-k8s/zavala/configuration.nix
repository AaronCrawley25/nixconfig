{ self, inputs, ... }:
{
  flake.nixosModules.zavala2 =
    { pkgs, lib, ... }:
    {
      services.k3s = {
        serverAddr = "https://10.9.8.7:6443";
        tokenFile = "/var/lib/rancher/k3s/token";
      };

      system.stateVersion = "26.05";
    };
}
