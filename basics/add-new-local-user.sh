#!/bin/bash
# This shell script adds users to the same Linux system as the script is executed on using positional 
# parameters to enter the user name and comments. It will also generate a random password for the new user account.

if [[ "${EUID}" -ne 0 ]]; then
  echo "Please run with sudo or as root."
  exit 1
fi

# Provide a usage statement if user does not supply an account name on the command line.
if [[ $# -lt 1 ]]; then
  echo "Usage: $0 USER_NAME [COMMENT]..."
  echo
  echo "Create a local user account with the specified username and optional comment."
  exit 1
fi

# Use the first argument on the command line as the username.
USER_NAME="$1"

# Shift off the username.
shift

# Use remaining arguments as the comment for the account.
REAL_NAME="$*"

# Automatically generate a password for the account.
PASSWORD=$(date +%s%N${RANDOM}${RANDOM} | sha256sum | head -c12)

# Create the user with the password.
useradd -m -c "${REAL_NAME}" "${USER_NAME}"

if [[ $? -ne 0 ]]; then
  echo "Account could not be created."
  exit 1
fi

# Set the password.
echo "${USER_NAME}:${PASSWORD}" | chpasswd

# Check to see if the passwd command succeeded.
if [[ $? -ne 0 ]]; then
  echo "Password was not set."
  exit 1
fi

# Force password change on first login.
passwd -e "${USER_NAME}"

# Display the username, password, and the host where the user was created.
echo
echo "username:"
echo "${USER_NAME}"
echo
echo "password:"
echo "${PASSWORD}"
echo
echo "host:"
hostname
