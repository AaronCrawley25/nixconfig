{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.base =
    { pkgs, ... }:
    {
      environment.systemPackages = with pkgs; [
        lsof
        pciutils
        inetutils
        dnsutils
        file
        tree
        usbutils
        unzip
        ripgrep
        fzf

        (pkgs.writeShellScriptBin "trim-generations" (builtins.readFile ./trim-generations.sh))

        (pkgs.writeShellApplication {
          name = "oopdate";

          runtimeInputs = with pkgs; [
            gum
          ];

          text = builtins.readFile ./oopdate.sh;
        })
      ];
    };
}
