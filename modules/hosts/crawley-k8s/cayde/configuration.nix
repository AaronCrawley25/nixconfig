{ self, inputs, ... }:
{
  flake.nixosModules.cayde =
    { pkgs, lib, ... }:
    {
      services.k3s = {
        serverAddr = "https://10.9.8.7:6443";
        tokenFile = "/var/lib/rancher/k3s/token";
        extraFlags = [
          "--tls-san=10.9.8.80"
        ];
      };

      system.stateVersion = "26.05";
    };
}
