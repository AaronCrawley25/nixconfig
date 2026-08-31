{ self, inputs, ... }:
{
  flake.nixosModules.raspberry-pi =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      # Add bonus kernel parameters if k3s enabled
      config = lib.mkIf config.services.k3s.enable {
        boot.kernelParams = [
          "cgroup_enable=cpuset"
          "cgroup_memory=1"
          "cgroup_enable=memory"
        ];
      };
    };
}
