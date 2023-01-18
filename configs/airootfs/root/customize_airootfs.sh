#!/bin/sh
set -e

hostname="archiso"
echo $hostname > /etc/hostname

ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen
echo 'LANG=en_US.UTF-8' > /etc/locale.conf
locale-gen

sed -i 's/^#Server/Server/' /etc/pacman.d/mirrorlist
pacman-key --init
pacman-key --populate

usermod -aG wheel,input,video,audio,kvm xundaoxd
sed -E -i '/^#\s*%wheel.*NOPASSWD/{s/^#\s*//}' /etc/sudoers

systemctl enable NetworkManager
systemctl enable sddm
systemctl enable sshd
systemctl enable bluetooth

su - xundaoxd -c 'install -Dm755 /usr/share/doc/bspwm/examples/bspwmrc ~/.config/bspwm/bspwmrc'
su - xundaoxd -c 'install -Dm644 /usr/share/doc/bspwm/examples/sxhkdrc ~/.config/sxhkd/sxhkdrc'

