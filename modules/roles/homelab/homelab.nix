{ self, inputs, ... }: {
  flake.nixosModules.homelab = { pkgs, lib, ... }: {
    environment.systemPackages = with pkgs; [
      kubectl
      kubectx
      argocd
      pv-migrate
      kubectl-cnpg
    ];

    virtualisation.docker = {
      enable = true;
      enableOnBoot = false;
    };

    boot.binfmt.emulatedSystems = [ "aarch64-linux" ];
  };
}
