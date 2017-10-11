## Mount Android phone for MTP file transfer

    sudo apt-get install jmtpfs
    mkdir ~/phone
    # unlock phone screen
    jmtpfs ~/phone
    # do stuff
    fusermount -u ~/phone
