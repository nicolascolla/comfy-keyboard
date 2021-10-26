# mount rootfs as rw
mount -o remount,rw /

# move to parent directory
cd /usr/share/maliit/plugins/com/ubuntu/lib/

# delete all files and restore backups
for D in ./*; do
	if [ -d "$D" ]; then
		cd "$D"
		if [ ! $(pwd) = "/usr/share/maliit/plugins/com/ubuntu/lib/emoji" ] && [ ! $(pwd) = "/usr/share/maliit/plugins/com/ubuntu/lib/ja" ] && [ ! $(pwd) = "/usr/share/maliit/plugins/com/ubuntu/lib/th" ]
			then rm Keyboard*.qml && mv ./backup/* . && rm -rf ./backup
		fi
		cd ..
	fi
done

# relock rootfs
mount -o remount,ro /
