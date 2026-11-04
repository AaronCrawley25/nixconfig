# My NixOS Config

## Installation

Firstly, write the minimal NixOS installer image to a USB, disable secure boot,
then boot into the USB.

Once booted, connect to the internet, either by plugging in an ethernet cord, or
by using `nmtui` to connect to Wi-Fi.

### Disk Partitioning

Format disk using `sudo fdisk /dev/nvme0n1` or equivalent for whichever disk.

#### Standard

1. `g` - create GPT table
2. `n` - new partition
3. `enter` - partition number, default
4. `enter` - first sector, default
5. `+1G` - last sector, 1GB
6. `y` - remove signature, if applicable
7. `t` - change partition type
8. `1` - partition type, EFI
9. Optionally, create swap partition
    - `n` - new partition
    - `enter` - partition number, default
    - `enter` - first sector, default
    - `+4G` - last sector, 4GB (or required size)
    - `y` - remove signature, if applicable
    - `t` - change partition type
    - `19` - partition type, Linux swap
10. `n` - new partition
11. `enter` - partition number, default
12. `enter` - first sector, default
13. `enter` - last sector, default
14. `y` - remove signature, if applicable
15. `t` - change partition type
16. `20` - partition type, Linux filesystem
17. `w` - write partition layout

```sh
# Format
mkfs.fat -F 32 -n NIXBOOT /dev/nvme0n1p1
mkswap -L NIXSWAP /dev/nvme0n1p2 # If swap partiton was created
mkfs.ext4 -L NIXROOT /dev/nvme0n1p3 # Note this would be p2 if swap

# Mount
mount /dev/disk/by-label/NIXROOT /mnt
mkdir /mnt/boot
mount -o umask=0077 /dev/disk/by-label/NIXBOOT /mnt/boot
swapon -L NIXSWAP # If swap partition was created

# Verify
lsblk -o name,label,size,type,mountpoints /dev/nvme0n1
```

#### LUKS Encrypted

1. `g` - create GPT table
2. `n` - new partition
3. `enter` - partition number, default
4. `enter` - first sector, default
5. `+1G` - last sector, 1GB
6. `y` - remove signature, if applicable
7. `t` - change partition type
8. `1` - partition type, EFI
9. `n` - new partition
10. `enter` - partition number, default
11. `enter` - first sector, default
12. `enter` - last sector, default
13. `y` - remove signature, if applicable
14. `t` - change partition type
15. `44` - partition type, Linux LVM
16. `w` - write partition layout

```sh
# Setup LVM
cryptsetup -v -y --label=NIXLUKS luksFormat --type luks2 /dev/nvme0n1p2
crpytsetup luksOpen /dev/nvme0n1p2 cryptroot
pvcreate /dev/mapper/cryptroot
vgcreate lvmroot /dev/mapper/cryptroot
lvcreate -L24G lvmroot -n swap # Optional for swap partition. Replace 24 with size
lvcreate -l 100%FREE lvmroot -n root

# Format
mkfs.fat -F 32 -n NIXBOOT /dev/nvme0n1p1
mkfs.ext4 -L NIXROOT /dev/mapper/lvmroot-root
mkswap -L NIXSWAP /dev/mapper/lvmroot-swap # Include if swap partition

# Mount
mount /dev/disk/by-label/NIXROOT /mnt
mkdir /mnt/boot
mount -o umask=0077 /dev/disk/by-label/NIXBOOT /mnt/boot
swapon -L NIXSWAP

# Verify
lsblk -o name,label,size,type,mountpoints /dev/nvme0n1
```

### Downloading Config

```sh
# Make config directory
mkdir -p /mnt/etc/nixos
cd /mnt/etc/nixos

# Clone repo
nix-shell -p git
git clone https://github.com/AaronCrawley25/nixconfig .
```

### New System Config

Copy the example host config in `/mnt/etc/nixos/modules/hosts` to create the new
system.

The `default.nix` file declares the host as a flake output, sets system
variables and determines imported modules.

The `configuration.nix` file contains host specific config.

Next we generate the hardware config.

```sh
nixos-generate-config --show-hardware-config --root /mnt > hardware-gen.nix
```

Put the output from that file inside the `hardware.nix` file

### Install Time!

```sh
# Make sure Nix sees the files we created!
cd /mnt/etc/nixos
git add *

# Install System
sudo nixos-install --root /mnt --no-root-passwd --flake /mnt/etc/nixos#hostname

# Set User Password
nixos-enter --root /mnt -c "passwd username"

# Reboot!
reboot
```

## Post Installation

### Enabling Secure Boot

Boot the device into secure boot setup mode. Then, change the boot regular role
to boot secure and rebuild. Then add the keys:

```sh
# Enrol
sudo sbctl enroll-keys --microsoft

# Confirm
bootctl status
```

### Putting LUKS keys in TPM

```sh
systemd-cryptenroll --wipe-slot=tpm2 --tpm2-device=auto --tpm-pcrs=0+7 /dev/disk/by-label/NIXLUKS
```
