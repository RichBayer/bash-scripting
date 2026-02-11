#!/bin/bash
# The purpose of this script is to add users to the same Linux system as the script is executed on.
# This is my first attempt at writing this script without referencing the lesson material or doing any sort of internet search.

# Exercise #2
# Make sure the script is being executed with superuser privileges.
# NOTE:
# During development, file ownership and permissions may be relaxed to allow
# editing as a non-root user (e.g., when using VS Code Remote-SSH).
# Before deployment, this script should be owned by root and set to mode 755.

if [[ "${EUID}" -ne 0 ]]; then
  echo "Please run with sudo or as root."
  exit 1
fi

# Get the username (login).
read -p "Enter Your Username: " USER_NAME

# Get the real name (contents for the description field).
read -p "Enter Your Real Name: " REAL_NAME

# Get the password.
read -p "Enter Your Password: " PASSWORD

# Create the user with the password.
useradd -m "${USER_NAME}" -c "${REAL_NAME}"
# I initially had this command here: useradd -m "${USER_NAME}" -c "${REAL_NAME}" | passwd "${PASSWORD}" "${USER_NAME}"
# But then I saw below that the exercise wanted me to set the password then check if the passwd command executed so I separated the commands.

# Check to see if the useradd command succeeded.
if [[ $? -gt 0 ]]
    then echo "Account Could Not be Created"
    else echo "Account Created Successfully"
exit 1
fi

# Set the password.
echo "${USER_NAME}:${PASSWORD}" | chpasswd

# Check to see if the passwd command succeeded.
if [[ $? -gt 0 ]]
    then echo "Password Not Set"
    else echo "Password Set Successfully"
exit 1
fi

# Force password change on first login.
passwd -e "{$USER_NAME}"

# Display the username, password, and the host where the user was created.
echo "{$USER_NAME}" ; echo "{$PASSWORD}" ; echo hostname 