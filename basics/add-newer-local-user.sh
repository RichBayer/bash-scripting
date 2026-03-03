#!/bin/bash
# This script adds to the previous scripts the use of redirection of stdout and stderr.
# This attempt I tried to rewrite the entire script from scratch, no copy and paste.

if [[ $EUID -ne 0 ]]; then
    echo "Please execute script as root or use sudu" >&2
    exit 1
fi

if [[ $# -lt 1 ]]; then
    echo "Usage: $0 USER_NAME [COMMENT]..." >&2
    echo
    echo "To create a new user account, provide a username and optional comment." >&2
    exit 1
fi

USER_NAME="$1"

shift

REAL_NAME="$*"

PASSWORD="head -c16 | dev/urandom | sha256sum | head -c16"

useradd -m -c "$REAL_NAME" "$USER_NAME"

if [[ $? -ne 0 ]]; then
    echo "Account not created" >&2
    exit 1
fi

echo "$USER_NAME":"$REAL_NAME" | chpasswd

passwd -e "$USER_NAME"

echo "username"
echo "$USER_NAME"
echo
echo "password"
echo "$PASSWORD"
echo
echo "host"
hostname
