Setting up Debian -Stretch- Buster/Sid (remember to check what you download...) from the netinst image on my Aspire 5741G

### Start

Boot into USB stick and follow instructions (wlan setup failed)

### Get connect to the internetz

- [install missing BRCM firmware](https://ubuntuforums.org/showthread.php?t=1593354&page=3), diagnosed by `dmesg | grep -i brcm`. On assistant machine: 

    git clone git://git.kernel.org/pub/scm/linux/kernel/git/dwmw2/linux-firmware.git
    sudo cp -a linux-firmware/brcm ... /lib/firmware/

- [How to use a wifi interface](https://wiki.debian.org/WiFi/HowToUse#Command_Line), run these as root:

    1. find wireless interface and bring it up (wlp3s0b1 instead of wlan0)
        
        ip a
        iwconfig
        ip link set wlp3s0b1 up

    2. Scan for available networks:

        iwlist scan

    3. Edit `/etc/network/interfaces` to automatically bring up the wireless network interface at boot

        auto wlp3s0b1

    and reboot. Network-Manager should handle everything (meaning that step 4 is redundant). Add networks using `nmtui`.

    4. `ifup` dat shit

    5. `ping` something

    6. `iwgetid` shows device name and network ESSID

### Software

- update mirror in `/etc/apt/sources.list

    echo deb http://ftp.de.debian.org/debian testing main contrib non-free >> /etc/apt/sources.list
    echo deb-src http://ftp.de.debian.org/debian testing main contrib non-free >> /etc/apt/sources.list

- install `sudo`

    apt-get install sudo
    usermod -a -G sudo <username>
    exit

- helpers:

    sudo apt-get update && sudo apt-get upgrade
    sudo apt-get install git rsync tmux

### More references

- [https://linuxpanda.wordpress.com/2014/03/02/guide-how-to-install-debian-8-jessie-xfce-using-netinst-minimal-iso-step-by-step-with-pictures/]()
