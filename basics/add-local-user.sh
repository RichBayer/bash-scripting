#!/bin/bash
# add-local-user.sh
# Creates a local user account on the system where it is executed.
# Prompts for username, real name, and password.
# Forces password change on first login.
# Must be executed with root privileges.

# Exercise #2
# Make sure the script is being executed with superuser privileges.
# NOTE:
# During development, ownership and permissions may be relaxed.
# For deployment, this script should be owned by root:root and set to mode 755.

if [[ "${EUID}" -ne 0 ]]; then
  echo "Please run with sudo or as root."
  exit 1
fi

# Get the username (login).
read -p "Enter Your Username: " USER_NAME

# Get the real name (contents for the description field).
read -p "Enter Your Real Name: " REAL_NAME

# Get the password.
read -s -p "Enter Your Password: " PASSWORD
echo

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

