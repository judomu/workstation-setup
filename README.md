# Workstation Setup (w/ Dotfiles)

Repo to setup my workstation (private + work), driven by [Ansible](https://www.ansible.com/) (IaC).

## Manual Steps

### Software
- Install [Manjaro i3](https://www.manjaro.org/downloads/community/i3/)
- Install Ansible: `sudo pacman -S ansible`
- Install Ansible AUR Helper: `sudo ansible-galaxy install kewlfft.aur`
- Install [Burp Suite Professional](https://portswigger.net/burp/pro)

### Configuration
- Restore backup
- Configure AWS Credentials `roles/base/files/.aws.cred`

## Automated Steps
- Exec Ansible Playbook: `sudo ansible-playbook setup.yml`

## Helpful Commands

- Find all manually installed pacmans: `pacman -Qe`
- Run only shell tasks: `sudo ansible-playbook setup.yml --tags "shell"`
- Get backup collection status `duplicity-backup -c duplicity-backup.conf -s`
- Get backup list `duplicity-backup -c duplicity-backup.conf -l > backup-list.txt`
- Restore specific folder `duplicity-backup -c duplicity-backup.conf --restore-dir "home/julian/.config/" "target"`
