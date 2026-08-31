{ self, inputs, ... }: {
  flake.nixosModules.server =
    {
      pkgs,
      lib,
      username,
      sshkey,
      ...
    }:
    {
      services.openssh = {
        enable = true;
        settings = {
          PermitRootLogin = "no";
          PasswordAuthentication = false;
        };
      };

      users.users.${username}.openssh.authorizedKeys.keys = [
        sshkey
      ];
    };
}
