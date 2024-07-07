<img src="https://github.com/acidanthera/OpenCorePkg/blob/master/Docs/Logos/OpenCore_with_text_Small.png" width="200" height="48"/>

**macOS Sonoma**: 14.5 (23F79) Dual Boot w/ **Windows 11**: 24H2

**OpenCore version**: 1.0.0 <br>

## My System

| **Component** | **Model**                       |
| ------------- | ------------------------------- |
| Motherboard   | ASUS ROG Strix B450-F Gaming    |
| CPU           | AMD Ryzen 5 3600 @ 3.6GHz       |
| GPU           | AMD Radeon RX 5700 XT           |
| RAM           | 24GB @ 3266 MHz                 |
| Storage       | NVMe SSD Lexar NM620, 240gb     |
| Ethernet      | I211 Gigabit Network Connection |
| WIFI + BT     | Fenvi BCM94360                  |

### Recommended software

1. AMD Power Gadget: https://github.com/trulyspinach/SMCAMDProcessor/releases - To read and adjust CPU clock frequencies

2. Monitor Control: https://github.com/MonitorControl/MonitorControl/releases - For adjusting the brightness of an external monitor

### Discord patch to fix Voice/Video crashing when join for AMD hackintosh system

1. npm install -g amdfriend

2. sudo amdfriend --in-place --sign ~/Library/Application\ Support/discord/0.0.309/modules/discord_krisp/discord_krisp.node

Make sure to check discord version under ~/Library/Application Support/discord to replace (0.0.309).

### Fix wrong windows time

1. Extract correction-windows-time-dualboot.zip

2. Execute WinUTCOn.reg

3. Reboot Windows
