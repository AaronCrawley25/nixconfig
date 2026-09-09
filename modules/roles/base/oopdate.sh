# Do a "system update" by pulling nixconfig and rebuilding
# TODO: gum spinners for long running tasks

# Pull new version of nixconfig
if gum confirm "Pull Changes from Git?"; then
    cd /etc/nixos
    git pull
fi

REBUILD_OPTION=$(gum choose "switch" "boot" "test")
sudo nixos-rebuild "$REBUILD_OPTION"

if gum confirm "Trim Generations?"; then
    yes | sudo trim-generations || : # optionally: EXITCODE=$?
fi

if gum confirm "Collect Garbage?"; then
    nix-store --gc
fi

