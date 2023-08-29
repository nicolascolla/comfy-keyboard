# get location of numbercolumn file
export WHERE=$(pwd)

modifykeyboard () {
	# Back up the original files
	mkdir backup
	cp Keyboard* backup

	# Remove all numbers from the top line
	sed -i s/\"[0-9]*\",//g Keyboard*qml
	sed -i s/\"[0-9]*\"//g Keyboard*qml
	sed -i 's/\"\\\ /\"\\"\"\ ,/g' Keyboard*qml # fix the "/" key, broken with the previous f*ckery
	sed -i 's/extended:\ \[\];\ extendedShifted:\ \[\];//g' Keyboard*.qml
	sed -i 's/extended:\ \[\];\ extendedShifted:\ \[\]//g' Keyboard*.qml

	# Add number row
	sed -i '0,/Row {/s/Row {/NUMBERSHERE\n\tRow {/' Keyboard*.qml
	sed -i '/NUMBERSHERE/e cat $WHERE/numbercolumn' Keyboard*qml
	sed -i '/NUMBERSHERE/d' Keyboard*.qml
}

# mount rootfs as rw
mount -o remount,rw /

# move to parent directory
cd /usr/lib/lomiri-keyboard/plugins/

# change all keyboards except the emoji, japanese or thai keyboard
for D in ./*; do
	if [ -d "$D" ]; then
		cd "$D"
		if [ ! $(pwd) = "/usr/lib/lomiri-keyboard/plugins/emoji" ] && [ ! $(pwd) = "/usr/lib/lomiri-keyboard/plugins/ja" ] && [ ! $(pwd) = "/usr/lib/lomiri-keyboard/plugins/th" ]
			then modifykeyboard
		fi
		cd ..
	fi
done

# relock rootfs
mount -o remount,ro /
