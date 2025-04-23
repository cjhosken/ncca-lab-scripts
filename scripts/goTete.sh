#!/usr/bin/env bash

USERNAME=$(whoami)
SERVER="tete.bournemouth.ac.uk"
SFTP_URI="sftp://$USERNAME@$SERVER"
MOUNT_DIR="$HOME/TETE"
ACTION="mount"  # default action

# Parse command line arguments
while [[ $# -gt 0 ]]; do
    case "$1" in
        -m |--mount)
            ACTION="mount"
            shift
            ;;
        -u|--unmount)
            ACTION="unmount"
            shift
            ;;
        -d|--dir)
            MOUNT_DIR="$2"
            shift 2
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

function mount_sftp() {

    # Check if already mounted
    if gio mount --list | grep -q "$SFTP_URI"; then
        echo "SFTP is already mounted."
    else
        echo "Mounting SFTP..."
        mkdir -p $MOUNT_DIR
        gio mount "$SFTP_URI"

        rm -rf $MOUNT_DIR

        ln -s "/run/user/$UID/gvfs/sftp:host=$SERVER,user=$USERNAME/home/$USERNAME" $MOUNT_DIR
    fi

}

function unmount_sftp() {
    gio mount -u sftp://$USERNAME@$SERVER
}


# Perform the requested action
case "$ACTION" in
    mount)
        mount_sftp
        ;;
    unmount)
        unmount_sftp
        ;;
    *)
        echo "Invalid action: $ACTION"
        exit 1
        ;;
esac

exit 0