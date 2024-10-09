<img src="https://github.com/acidanthera/OpenCorePkg/blob/master/Docs/Logos/OpenCore_with_text_Small.png" width="200" height="48"/>

**macOS Sequoia**: 15.0.1 (24A348) Dual Boot w/ **Windows 10**: 22H2

**OpenCore version**: 1.0.2 <br>

## My System

| **Component** | **Model**                       |
| ------------- | ------------------------------- |
| Motherboard   | ASUS ROG Strix B450-F Gaming    |
| CPU           | AMD Ryzen 5 3600 @ 3.6GHz       |
| GPU           | AMD Radeon RX 5700 XT           |
| RAM           | 32GB @ 3000 MHz                 |
| Storage       | NVMe SSD Lexar NM620, 240gb     |
| Ethernet      | I211 Gigabit Network Connection |
| WIFI + BT     | Fenvi BCM94360                  |

### Recommended software

1. Monitor Control: https://github.com/MonitorControl/MonitorControl/releases - For adjusting the brightness of an external monitor

### Discord patch to fix Voice/Video crashing when join for AMD hackintosh system

2. npm install -g friendlyamd

3. sudo friendlyamd --in-place --sign ~/Library/Application\ Support/discord/0.0.309/modules/discord_krisp/discord_krisp.node

Make sure to check discord version under ~/Library/Application Support/discord to replace (0.0.309).

Or execute this script [Discord patch](/Resources/discord_patch.sh)

### Fix wrong windows time

4. Extract correction-windows-time-dualboot.zip

5. Execute WinUTCOn.reg

6. Reboot Windows

### Post-Installation

7. Copy your EFI directory onto your main drive EFI partition, you'll be able to boot the system without your bootable USB.

8. Apply [Ryzen patch script](/Resources/ryzen_patch.sh) - it solves MKL (Math Kernel Library) issues and sets correct sleep parameters.

There's also `intel_fast_memset` instruction which, obviously, doesn't exist on AMD systems. It's very common in Adobe software - you can simply fix it by running [this script](/Resources/adobe_patch.sh). Older versions of Adobe software (e. g. up to 22.3.1 for Photoshop) need it's [legacy version](/Resources/adobe_patch_legacy.sh).
