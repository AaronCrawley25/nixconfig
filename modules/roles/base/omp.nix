{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.base =
    { pkgs, ... }:
    let
      omp-theme = pkgs.stdenvNoCC.mkDerivation {
        name = "omp-theme";
        src = ./.;
        dontUnpack = true;
        installPhase = ''
          cp $src/omp.json $out
        '';
      };
    in
    {
      home = {
        programs.oh-my-posh = {
          enable = true;
          settings = builtins.fromJSON (
            builtins.unsafeDiscardStringContext (builtins.readFile "${omp-theme}")
          );
        };
      };
    };
}
