<img src="https://github.com/acidanthera/OpenCorePkg/blob/master/Docs/Logos/OpenCore_with_text_Small.png" width="200" height="48"/>

**macOS Ventura**: 13.5 (22G74) Dual Boot w/ **Windows 11**: 22H2

**OpenCore version**: 0.9.4 <br>

## My System

| **Component** | **Model**                       |
| ------------- | ------------------------------- |
| Motherboard   | ASUS ROG Strix B450-F Gaming    |
| CPU           | AMD Ryzen 5 3600 @ 3.6GHz       |
| GPU           | AMD Radeon RX 5700 XT           |
| RAM           | 24GB @ 3266 MHz                 |
| Storage       | NVMe SSD Lexar NM620, 240gb     |
| Ethernet      | I211 Gigabit Network Connection |
| Wifi + Bt     | Fenvi BCM94360                  |

### Recommended software

1. AMD Power Gadget: https://github.com/trulyspinach/SMCAMDProcessor/releases - To read and adjust CPU clock frequencies

2. Monitor Control: https://github.com/MonitorControl/MonitorControl/releases - For adjusting the brightness of an external monitor

### Fix Discord desktop app voice/screensharing

1. Copy the environment.plist file into `$HOME/Library/LaunchAgents/`

2. Reboot macOS

### Fix wrong windows time

1. Extract correction-windows-time- dualboot.zip

2. Execute WinUTCOn.reg

3. Reboot Windows

### Adobe software fix

To fix Adobe copy and paste this into a terminal enter password if it asks

If it still keeps crashing read this [Guide](https://gist.github.com/naveenkrdy/26760ac5135deed6d0bb8902f6ceb6bd)

```
for file in MMXCore FastCore TextModel libiomp5.dylib libtbb.dylib libtbbmalloc.dylib; do
	find /Applications/Adobe* -type f -name $file | while read -r FILE; do
		sudo -v
		echo "found $FILE"
		[[ ! -f ${FILE}.back ]] && sudo cp -f $FILE ${FILE}.back || sudo cp -f ${FILE}.back $FILE
		echo $FILE | grep libiomp5 >/dev/null
		if [[ $? == 0 ]]; then
			dir=$(dirname "$FILE")
			[[ ! -f ${HOME}/libiomp5.dylib ]] && cd $HOME && curl -sO https://excellmedia.dl.sourceforge.net/project/badgui2/libs/mac64/libiomp5.dylib
			echo -n "replacing " && sudo cp -vf ${HOME}/libiomp5.dylib $dir && echo
			rm -f ${HOME}/libiomp5.dylib
			continue
		fi
		echo $FILE | grep TextModel >/dev/null
		[[ $? == 0 ]] && echo "emptying $FILE" && sudo echo -n >$FILE && continue
		echo "patching $FILE \n"
		sudo perl -i -pe 's|\x90\x90\x90\x90\x56\xE8\x6A\x00|\x90\x90\x90\x90\x56\xE8\x3A\x00|sg' $FILE
		sudo perl -i -pe 's|\x90\x90\x90\x90\x56\xE8\x4A\x00|\x90\x90\x90\x90\x56\xE8\x1A\x00|sg' $FILE
	done
done

```
