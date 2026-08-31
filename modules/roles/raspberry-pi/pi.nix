{ self, inputs, ... }:
{
  flake.nixosModules.raspberry-pi =
    {
      pkgs,
      lib,
      nixos-raspberrypi,
      username,
      ...
    }:
    {
      imports = with nixos-raspberrypi.nixosModules; [
        nixos-raspberrypi.lib.inject-overlays
        raspberry-pi-5.base
        raspberry-pi-5.page-size-16k
      ];

      boot.loader.raspberry-pi.bootloader = "kernel";

      # Haha insecure password in plaintext go brrrrrrr
      users.users.${username}.initialPassword = "wordpass12";

      # Becuase the base includes the stuff normally in hardware config
      # we can just put the sd card file system in and call it a day
      fileSystems = {
        "/boot/firmware" = {
          device = "/dev/disk/by-label/FIRMWARE";
          fsType = "vfat";
          options = [
            "umask=0077"
            "noatime"
            "noauto"
            "x-systemd.automount"
            "x-systemd.idle-timeout=1min"
          ];
        };
        "/" = {
          device = "/dev/disk/by-label/NIXOS_SD";
          fsType = "ext4";
          options = [ "noatime" ];
        };
      };

      nixpkgs.hostPlatform = lib.mkDefault "aarch64-linux";
    };
}
