{ self, inputs, ... }:
{
  flake.nixosModules.gamerbox =
    { pkgs, lib, ... }:
    let
      rgb-theme = pkgs.stdenvNoCC.mkDerivation {
        name = "Default.orp";
        src = ./.;
        dontUnpack = true;
        installPhase = ''
          cp $src/Default.orp $out
        '';
      };
    in
    {
      environment.systemPackages = with pkgs; [
        headsetcontrol
      ];

      hardware.nvidia = {
        # enabled = true;
        open = true;
      };

      # Cachyos kernel for gamering
      nixpkgs.overlays = [ inputs.nix-cachyos-kernel.overlays.pinned ];
      boot.kernelPackages = pkgs.cachyosKernels.linuxPackages-cachyos-latest;

      # RGB control
      services.hardware.openrgb = {
        enable = true;
        package = pkgs.openrgb-with-all-plugins;
        startupProfile = "${rgb-theme}";
      };

      hardware.bluetooth.enable = true;

      system.stateVersion = "26.05";
    };
}
