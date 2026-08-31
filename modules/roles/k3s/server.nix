{ self, inputs, ... }: {
  flake.nixosModules.k3s-server = { pkgs, lib, ... }: {
    imports = [
      self.nixosModules.k3s-common
    ];

    services.k3s = {
      role = "server";

      disable = [
        "servicelb"
        "traefik"
      ];

      extraFlags = [
        "--etcd-expose-metrics"
        "--kube-controller-manager-arg \"bind-address=0.0.0.0\""
        "--kube-scheduler-arg \"bind-address=0.0.0.0\""
        "--kube-proxy-arg \"metrics-bind-address=0.0.0.0\""
      ];
    };
  };
}
