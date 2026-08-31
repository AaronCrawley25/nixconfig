{ self, inputs, ... }: {
  flake.nixosModules.bootSecure = { pkgs, lib, ... }: {
    imports = [
      inputs.lanzaboote.nixosModules.lanzaboote
    ];

    environment.systemPackages = with pkgs; [
      sbctl
      tpm2-tss
    ];

    boot.loader.systemd-boot.enable = lib.mkForce false;
    boot.initrd.systemd.enable = true;

    boot.lanzaboote = {
      enable = true;
      pkiBundle = "/var/lib/sbctl";
      autoGenerateKeys.enable = true;
      autoEnrollKeys = {
        enable = true;
        autoReboot = true;
      };
    };
  };
}
