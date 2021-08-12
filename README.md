# Workstation Setup (w/ Dotfiles)

Repo to setup my workstation (private + work), driven by [Ansible](https://www.ansible.com/) (IaC).

## Steps

- Install [Manjaro i3](https://www.manjaro.org/downloads/community/i3/)
- Install Ansible: `sudo pacman -S ansible`
- Install Ansible AUR Helper: `sudo ansible-galaxy install kewlfft.aur`
- Install [Burp Suite Professional](https://portswigger.net/burp/pro)
- Clone this repo `git clone git@github.com:judomu/workstation-setup.git`
- Manually restore:
-- AWS Credentials to `workstation-setup/roles/base/files/.aws.cred` and `~/.aws.cred`
-- SSH Certificates (private + public) to `~/.ssh`
-- Duplicity Backup Configs
- Run Ansible Playbook: `sudo ansible-playbook -v setup.yml`
- Configure zsh as default shell: `chsh -s /bin/zsh`
- Restore backup `sudo duplicity-backup -c duplicity-backup.conf --restore /home/judomu/backup_restore`
- Copy backup folders to target folders
- Run and configure thunderbird `thunderbird --profile $PWD/m9jhh2lh.default` + `thunderbird --ProfileManager`

## Helpful Commands

- Find all manually installed pacmans: `pacman -Qe`
- Run only shell tasks: `sudo ansible-playbook setup.yml --tags "shell"`
- Get backup collection status `duplicity-backup -c duplicity-backup.conf -s`
- Get backup list `duplicity-backup -c duplicity-backup.conf -l > backup-list.txt`
- Restore specific folder `duplicity-backup -c duplicity-backup.conf --restore-dir "home/judomu/.config/" "target"`

## Laptop notes

### Lenovo P14s (AMD)

#### Solving known issues

- Sound not working? Configure `/etc/modprobe/alsa.conf` with
```
options snd_hda_intel enable=0,1
options snd slots=snd_hda_intel, thinkpad_acpi
options snd_hda_intel index=0
options thinkpad_acpi index=1
```
- WIFI not working? Install driver with `sudo pacman -S linux-headers` + `trizen -S rtw89-dkms-git`
- Install pulse audio `sudo install_pulse` (maybe cleanup with `rm -r .config/pulse` if not working)
- Flickering? Verify `/etc/X11/xorg.conf.d/20-amdgpu.conf` contains
```
Section "Device"
        Identifier "AMD"
        Driver "amdgpu"
        Option "TearFree" "true"
EndSection
```

#### inxi

```
➜ inxi -Fxza --no-host                        
System:    Kernel: 5.10.56-1-MANJARO x86_64 bits: 64 compiler: gcc v: 11.1.0
           parameters: BOOT_IMAGE=/boot/vmlinuz-5.10-x86_64
           root=UUID=2a74b055-3146-4179-955c-f6b92b1cfe4e rw quiet
           cryptdevice=UUID=afa81ead-45f7-4fe4-8b7e-614ca3222ca8:luks-afa81ead-45f7-4fe4-8b7e-614ca3222ca8
           root=/dev/mapper/luks-afa81ead-45f7-4fe4-8b7e-614ca3222ca8 apparmor=1 security=apparmor
           resume=/dev/mapper/luks-911cd054-4ac1-44a2-bc1f-9e32a498b524 udev.log_priority=3
           Desktop: i3 4.19.1 info: i3bar vt: 7 dm: LightDM 1.30.0 Distro: Manjaro Linux
           base: Arch Linux
Machine:   Type: Laptop System: LENOVO product: 21A0CTO1WW v: ThinkPad P14s Gen 2a serial: <filter>
           Chassis: type: 10 serial: <filter>
           Mobo: LENOVO model: 21A0CTO1WW serial: <filter> UEFI: LENOVO v: R1MET35W (1.05 )
           date: 04/23/2021
Battery:   ID-1: BAT0 charge: 51.3 Wh (99.2%) condition: 51.7/51.0 Wh (101.4%) volts: 13.1
           min: 11.5 model: Celxpert 5B10W51829 type: Li-poly serial: <filter> status: Unknown
           cycles: 5
           Device-1: hidpp_battery_3 model: Logitech M720 Triathlon Multi-Device Mouse
           serial: <filter> charge: 55% (should be ignored) rechargeable: yes status: Discharging
CPU:       Info: 8-Core model: AMD Ryzen 7 PRO 5850U with Radeon Graphics bits: 64 type: MT MCP
           arch: Zen 3 family: 19 (25) model-id: 50 (80) stepping: 0 microcode: A50000C cache:
           L2: 4 MiB
           flags: avx avx2 lm nx pae sse sse2 sse3 sse4_1 sse4_2 sse4a ssse3 svm bogomips: 60717
           Speed: 1352 MHz min/max: 1600/1900 MHz boost: enabled Core speeds (MHz): 1: 1352 2: 1526
           3: 1439 4: 1553 5: 1458 6: 1410 7: 1417 8: 1579 9: 1945 10: 1375 11: 1358 12: 1539
           13: 1508 14: 1581 15: 1480 16: 1506
           Vulnerabilities: Type: itlb_multihit status: Not affected
           Type: l1tf status: Not affected
           Type: mds status: Not affected
           Type: meltdown status: Not affected
           Type: spec_store_bypass
           mitigation: Speculative Store Bypass disabled via prctl and seccomp
           Type: spectre_v1 mitigation: usercopy/swapgs barriers and __user pointer sanitization
           Type: spectre_v2
           mitigation: Full AMD retpoline, IBPB: conditional, IBRS_FW, STIBP: always-on, RSB filling
           Type: srbds status: Not affected
           Type: tsx_async_abort status: Not affected
Graphics:  Device-1: AMD Cezanne vendor: Lenovo driver: amdgpu v: kernel bus-ID: 07:00.0
           chip-ID: 1002:1638 class-ID: 0300
           Device-2: IMC Networks Integrated Camera type: USB driver: uvcvideo bus-ID: 1-2:2
           chip-ID: 13d3:5406 class-ID: fe01 serial: <filter>
           Device-3: ARC Camera type: USB driver: snd-usb-audio,uvcvideo bus-ID: 3-1.3:5
           chip-ID: 05a3:9331 class-ID: 0102 serial: <filter>
           Display: x11 server: X.Org 1.20.13 compositor: picom v: git-dac85 driver:
           loaded: amdgpu,ati unloaded: modesetting alternate: fbdev,vesa display-ID: :0 screens: 1
           Screen-1: 0 s-res: 5760x1200 s-dpi: 96 s-size: 1524x317mm (60.0x12.5")
           s-diag: 1557mm (61.3")
           Monitor-1: eDP res: 1920x1080 hz: 60 dpi: 158 size: 309x173mm (12.2x6.8")
           diag: 354mm (13.9")
           Monitor-2: DisplayPort-3 res: 1920x1200 hz: 60 dpi: 94 size: 518x324mm (20.4x12.8")
           diag: 611mm (24.1")
           Monitor-3: DisplayPort-4 res: 1920x1200 hz: 60 dpi: 94 size: 518x324mm (20.4x12.8")
           diag: 611mm (24.1")
           OpenGL: renderer: AMD RENOIR (DRM 3.40.0 5.10.56-1-MANJARO LLVM 12.0.1)
           v: 4.6 Mesa 21.1.6 direct render: Yes
Audio:     Device-1: AMD vendor: Lenovo driver: N/A alternate: snd_hda_intel bus-ID: 07:00.1
           chip-ID: 1002:1637 class-ID: 0403
           Device-2: AMD Raven/Raven2/FireFlight/Renoir Audio Processor vendor: Lenovo
           driver: snd_rn_pci_acp3x v: kernel alternate: snd_pci_acp3x bus-ID: 07:00.5
           chip-ID: 1022:15e2 class-ID: 0480
           Device-3: AMD Family 17h HD Audio vendor: Lenovo driver: snd_hda_intel v: kernel
           bus-ID: 07:00.6 chip-ID: 1022:15e3 class-ID: 0403
           Device-4: Lenovo ThinkPad Thunderbolt 3 Dock USB Audio type: USB
           driver: hid-generic,snd-usb-audio,usbhid bus-ID: 3-1.1.1.2:10 chip-ID: 17ef:3083
           class-ID: 0300 serial: <filter>
           Device-5: ARC Camera type: USB driver: snd-usb-audio,uvcvideo bus-ID: 3-1.3:5
           chip-ID: 05a3:9331 class-ID: 0102 serial: <filter>
           Device-6: Sennheiser Headset [PC 8] type: USB driver: hid-generic,snd-usb-audio,usbhid
           bus-ID: 5-2:4 chip-ID: 1395:0025 class-ID: 0300
           Sound Server-1: ALSA v: k5.10.56-1-MANJARO running: yes
           Sound Server-2: JACK v: 1.9.19 running: no
           Sound Server-3: PulseAudio v: 15.0 running: yes
Network:   Device-1: Realtek RTL8111/8168/8411 PCI Express Gigabit Ethernet vendor: Lenovo
           driver: r8169 v: kernel port: 4000 bus-ID: 02:00.0 chip-ID: 10ec:8168 class-ID: 0200
           IF: enp2s0f0 state: down mac: <filter>
           Device-2: Realtek vendor: Lenovo driver: N/A port: 3000 bus-ID: 03:00.0
           chip-ID: 10ec:8852 class-ID: 0280
           Device-3: Realtek RTL8111/8168/8411 PCI Express Gigabit Ethernet vendor: Lenovo
           driver: r8169 v: kernel port: 2000 bus-ID: 05:00.0 chip-ID: 10ec:8168 class-ID: 0200
           IF: enp5s0 state: down mac: <filter>
           Device-4: Lenovo ThinkPad TBT 3 Dock type: USB driver: r8152 bus-ID: 4-1.1.2:4
           chip-ID: 17ef:3082 class-ID: 0000 serial: <filter>
           IF: enp7s0f3u1u1u2 state: up speed: 1000 Mbps duplex: full mac: <filter>
           IF-ID-1: br-e7503b00cb9c state: up speed: 10000 Mbps duplex: unknown mac: <filter>
           IF-ID-2: docker0 state: down mac: <filter>
           IF-ID-3: veth1a35934 state: up speed: 10000 Mbps duplex: full mac: <filter>
           IF-ID-4: veth3bf951d state: up speed: 10000 Mbps duplex: full mac: <filter>
           IF-ID-5: veth4cb2360 state: up speed: 10000 Mbps duplex: full mac: <filter>
           IF-ID-6: veth69d3e6d state: up speed: 10000 Mbps duplex: full mac: <filter>
           IF-ID-7: veth8f6c7b7 state: up speed: 10000 Mbps duplex: full mac: <filter>
           IF-ID-8: vetha3777ce state: up speed: 10000 Mbps duplex: full mac: <filter>
           IF-ID-9: vethbf1ee24 state: up speed: 10000 Mbps duplex: full mac: <filter>
           IF-ID-10: vethddfbdb8 state: up speed: 10000 Mbps duplex: full mac: <filter>
           IF-ID-11: vethe9364e5 state: up speed: 10000 Mbps duplex: full mac: <filter>
Bluetooth: Device-1: Realtek Bluetooth Radio type: USB driver: btusb v: 0.8 bus-ID: 5-4:3
           chip-ID: 0bda:4852 class-ID: e001 serial: <filter>
           Report: rfkill ID: hci0 rfk-id: 5 state: up address: see --recommends
Drives:    Local Storage: total: 953.87 GiB used: 169.67 GiB (17.8%)
           SMART Message: Required tool smartctl not installed. Check --recommends
           ID-1: /dev/nvme0n1 maj-min: 259:0 vendor: SK Hynix model: HFS001TDE9X081N
           size: 953.87 GiB block-size: physical: 512 B logical: 512 B speed: 31.6 Gb/s lanes: 4
           type: SSD serial: <filter> rev: 41710C20 temp: 46.9 C scheme: GPT
Partition: ID-1: / raw-size: 906.25 GiB size: 890.92 GiB (98.31%) used: 169.67 GiB (19.0%) fs: ext4
           dev: /dev/dm-0 maj-min: 254:0 mapped: luks-afa81ead-45f7-4fe4-8b7e-614ca3222ca8
           ID-2: /boot/efi raw-size: 300 MiB size: 299.4 MiB (99.80%) used: 440 KiB (0.1%) fs: vfat
           dev: /dev/nvme0n1p1 maj-min: 259:1
Swap:      Kernel: swappiness: 60 (default) cache-pressure: 100 (default)
           ID-1: swap-1 type: partition size: 47.31 GiB used: 0 KiB (0.0%) priority: -2
           dev: /dev/dm-1 maj-min: 254:1 mapped: luks-911cd054-4ac1-44a2-bc1f-9e32a498b524
Sensors:   System Temperatures: cpu: 47.0 C mobo: 0.0 C gpu: amdgpu temp: 44.0 C
           Fan Speeds (RPM): cpu: 2900
Info:      Processes: 464 Uptime: 17h 8m wakeups: 31 Memory: 43.01 GiB used: 17.21 GiB (40.0%)
           Init: systemd v: 248 tool: systemctl Compilers: gcc: 11.1.0 Packages: 1226 pacman: 1216
           lib: 320 snap: 10 Shell: Zsh v: 5.8 running-in: urxvtd inxi: 3.3.06
```
