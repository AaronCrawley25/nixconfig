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
        2379
        2380
        6443
        10250

        80
        443
        53
        853
      ];

      networking.firewall.allowedUDPPorts = [
        8472
        51820
        51821
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
