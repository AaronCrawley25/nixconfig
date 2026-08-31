{ self, inputs, ... }: {
  flake.nixosModules.workstation = { pkgs, lib, ... }: {
    services = {
      power-profiles-daemon.enable = true;

      udev.extraRules = ''
        # AC plugged in
                SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ENV{POWER_SUPPLY_ONLINE}=="1", ACTION=="change", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set performance"

        # On battery
                SUBSYSTEM=="power_supply", ATTR{type}=="Mains", ENV{POWER_SUPPLY_ONLINE}=="0", ACTION=="change", RUN+="${pkgs.power-profiles-daemon}/bin/powerprofilesctl set power-saver"
      '';
    };

    powerManagement.powertop.enable = true;
  };
}
