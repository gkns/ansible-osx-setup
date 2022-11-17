# MacOS Setup with Ansible

This repository contains an Ansible configuration for setting up a Mac from scratch. It's primary purpose is setting up a new Mac from scratch, but I endeavor to also use it for adding new software as I go so that it remains up to date. At the moment it's being used for setting up M1 based Macs running MacOS Monterey.

This is my (@gkns) version of the original scripts.
My changes/customisations are:

1. Added my applications.
2. Install asdf through homebrew instead of git repo.
3. Add my dotfile templates to dropbox and download them for the configuration
4. Added a log (A simple tee) and made the ansible output verbose.
5. Added instructions to test + dry-run changes.



## Getting Started

There's a simple shell script in `bin/bootstrap` which will perform the initial steps of:

1. Installing Xcode
2. Installing Ansible
3. Fetching required Ansible roles and collections

And then runs the main playbook `ansible_osx.yml`.

For future updates, `bin/apply` can be used to run just the Ansible playbook without the setup commands.

It's important to note that this isn't designed to be particularly robust, particularly when it comes to required env vars, it may be required to run this. Then close the terminal and open it again and re-run and then repeat this process a few times.

## What's installed

The easiest way to understand what's installed is to read the contents of `ansible_osx.yml`, this configuration is fairly specific to the range of development I do personally, but may serve as a useful starting point for others.

## Customising

Everything can be customised by editing `ansible_osx.yml`.
After customising you might want to run the below checks in the Testing section to verify the changes are okay.


## Testing

To check the playbook syntax : `ansible-playbook --syntax-check -i "localhost," -c local ansible_osx.yml`
To check the playbook (Dry run) : `ansible-playbook --check -i "localhost," -c local ansible_osx.yml --ask-become-pass`
