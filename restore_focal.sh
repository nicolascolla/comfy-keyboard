# mount rootfs as rw
mount -o remount,rw /

# move to parent directory
cd /usr/lib/lomiri-keyboard/plugins/

# delete all files and restore backups
for D in ./*; do
	if [ -d "$D" ]; then
		cd "$D"
		if [ ! $(pwd) = "/usr/lib/lomiri-keyboard/plugins/emoji" ] && [ ! $(pwd) = "/usr/lib/lomiri-keyboard/plugins/ja" ] && [ ! $(pwd) = "/usr/lib/lomiri-keyboard/plugins/th" ]
			then rm Keyboard*.qml && mv ./backup/* . && rm -rf ./backup
		fi
		cd ..
	fi
done

# relock rootfs
mount -o remount,ro /
