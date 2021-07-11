# Workstation Setup (w/ Dotfiles)

Repo to setup my workstation (private + work), driven by [Ansible](https://www.ansible.com/) (IaC).

## Steps

### Software
- Install [Manjaro i3](https://www.manjaro.org/downloads/community/i3/)
- Install Ansible: `sudo pacman -S ansible`
- Install Ansible AUR Helper: `sudo ansible-galaxy install kewlfft.aur`
- Install [Burp Suite Professional](https://portswigger.net/burp/pro)
- Set zsh as default shell (https://wiki.archlinux.org/title/Command-line_shell#Changing_your_default_shell)

### Configuration
- Restore backup `duplicity-backup -c duplicity-backup.conf --restore /home/judomu/backup_restore`
- Copy backup folders to target folders
- Configure thunderbird `thunderbird --ProfileManager`
- Configure AWS Credentials `roles/base/files/.aws.cred`

## Automated Steps
- Exec Ansible Playbook: `sudo ansible-playbook setup.yml`

## Helpful Commands

- Find all manually installed pacmans: `pacman -Qe`
- Run only shell tasks: `sudo ansible-playbook setup.yml --tags "shell"`
- Get backup collection status `duplicity-backup -c duplicity-backup.conf -s`
- Get backup list `duplicity-backup -c duplicity-backup.conf -l > backup-list.txt`
- Restore specific folder `duplicity-backup -c duplicity-backup.conf --restore-dir "home/julian/.config/" "target"`

## Laptop notes

### Lenovo P14s

- Sound not working? Configure `/etc/modprobe/alsa.conf` with
```
options snd_hda_intel enable=0,1
options snd slots=snd_hda_intel, thinkpad_acpi
options snd_hda_intel index=0
options thinkpad_acpi index=1
```
- WIFI not working? Install driver with `sudo pacman -S linux-headers` + `trizen -S rtw89-dkms-git`
