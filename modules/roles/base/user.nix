{
  self,
  inputs,
  ...
}:
{
  flake.nixosModules.base =
    {
      pkgs,
      lib,
      username,
      ...
    }:
    {
      home-manager = {
        useUserPackages = true;
        useGlobalPkgs = true;
        backupFileExtension = "bak";
        extraSpecialArgs = {
          inherit inputs;
        };

        users.${username} = {
          home = {
            username = "${username}";
            homeDirectory = "/home/${username}";
            stateVersion = "25.11";
          };
        };
      };

      # Define a user account. Don't forget to set a password with ‘passwd’.
      users.users.${username} = {
        isNormalUser = true;
        description = "${username}";
        extraGroups = [
          "networkmanager"
          "wheel"
          "docker"
          "lp"
          "libvirt"
          "video"
          "input"
          "uinput"
        ];
      };
    };
}
