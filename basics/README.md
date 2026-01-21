Bash Scripting – Basics Exercises

This directory contains instructor-led exercises completed while working through a Bash scripting course. The scripts here were written to learn Bash syntax, flow control, and basic system administration tasks. These exercises follow the structure and intent of the course as closely as possible.

Lesson 2 – Add Local User Script

Script name: add-local-user.sh

Scenario
As a Linux system administrator, frequent requests from the help desk to create new user accounts are interrupting server deployment work. To reduce these interruptions and speed up account creation, a shell script is written so the help desk can safely create local Linux user accounts without direct administrator involvement.

Goal
The goal of this exercise is to create a shell script that adds a local user to the Linux system on which the script is executed.

Requirements
The script must be named add-local-user.sh and must be executed with superuser (root) privileges. If the script is not run as root, it should not attempt to create a user and must exit with a status code of 1.

When executed, the script should prompt for a username, the real name of the person or application using the account, and an initial password. Using this input, the script should create a new local user on the system.

If user creation fails for any reason, the script should inform the operator and exit with a status code of 1. If successful, the script should force a password change on first login.

After completion, the script should display the username, password, and the hostname of the system where the account was created so the help desk can easily pass this information to the new user.

Concepts practiced
This exercise introduces checking for superuser privileges, reading user input, creating users with useradd, setting and expiring passwords with passwd, checking exit statuses, and retrieving hostname information from the system.

Notes
The course originally uses a Vagrant-based virtual machine for development. For this exercise, an existing LinuxPractice virtual machine was used instead. The script was written and tested directly on the Linux system.