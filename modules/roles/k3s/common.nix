{ self, inputs, ... }: {
  flake.nixosModules.k3s-common =
    {
      pkgs,
      lib,
      config,
      ...
    }:
    {
      services.k3s = {
        enable = true;
        package = pkgs.k3s_1_35;
      };

      networking.firewall.allowedTCPPorts = [
        2379 # etcd
        2380 # etcd
        6443 # api server
        10250 # metrics

        2381 # etcd metrics
        10257 # kube-controller-manager metrics
        10259 # kube-scheduler metrics

        80 # http lb
        443 # https lb
        53 # dns lb
        853 # dot lb
      ];

      networking.firewall.allowedUDPPorts = [
        8472 # flannel
        51820 # flannel
        51821 # flannel
      ];

      environment.systemPackages = with pkgs; [
        nfs-utils
        cryptsetup
      ];

      services.lvm.enable = true;

      services.openiscsi = {
        enable = true;
        name = "${config.networking.hostName}-initiatorhost";
      };

      systemd.services.iscsid.serviceConfig = {
        PrivateMounts = "yes";
        BindPaths = "/run/current-system/sw/bin:/bin";
      };

      boot.kernelModules = [
        "dm_crypt"
      ];

      systemd.tmpfiles.rules = [
        # Create a symbolic link /usr/bin/cryptsetup -> /run/current-system/sw/bin/cryptsetup
        "L /usr/sbin/cryptsetup - - - - /run/current-system/sw/bin/cryptsetup"
        "L /usr/bin/mount - - - - /run/current-system/sw/bin/mount"
      ];
    };
}
