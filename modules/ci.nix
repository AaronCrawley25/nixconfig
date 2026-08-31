{ self, inputs, ... }: {
  # Generate Github Matrix
  flake.githubActions = inputs.nix-github-actions.lib.mkGithubMatrix { checks = self.packages; };

  # Build these annoying ahh packages
  flake.packages."x86_64-linux".quickshell-niri = inputs.qml-niri.packages."x86_64-linux".quickshell;
  flake.packages."x86_64-linux".bezel = inputs.bezel.packages."x86_64-linux".default;
  flake.packages."aarch64-linux".linux_rpi5 =
    inputs.nixos-raspberrypi.packages."aarch64-linux".linux_rpi5;
}
