{ self, inputs, ... }:
let
  system = "x86_64-linux";
in
{
  flake.packages.${system}.quickshell-niri = inputs.qml-niri.packages.${system}.quickshell;
}
