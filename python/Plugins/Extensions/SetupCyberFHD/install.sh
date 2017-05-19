#!/bin/sh

case $1 in
	skin)
		SRC="https://raw.githubusercontent.com/Dima73/CyberFHD/master/share/enigma2/Cyber_fhd/skin.xml"
		DEST=/tmp/skin.xml
		SRC1="https://raw.githubusercontent.com/Dima73/CyberFHD/master/share/enigma2/Cyber_fhd/skin_default.xml"
		DEST1=/tmp/skin_default.xml
		SRC2="https://raw.githubusercontent.com/Dima73/CyberFHD/master/share/enigma2/Cyber_fhd/skin_templates.xml"
		DEST2=/tmp/skin_templates.xml
		SRC3="https://raw.githubusercontent.com/Dima73/CyberFHD/master/share/enigma2/Cyber_fhd/skin_templates_default.xml"
		DEST3=/tmp/skin_templates_default.xml
		if which curl >/dev/null 2>&1 ; then
			curl -o $DEST $SRC
			curl -o $DEST1 $SRC1
			curl -o $DEST2 $SRC2
			curl -o $DEST3 $SRC3
		else
			echo >&2 "install-skin: cannot find curl"
			opkg update && opkg install curl
			if which curl >/dev/null 2>&1 ; then
				curl -o $DEST $SRC
				curl -o $DEST1 $SRC1
				curl -o $DEST2 $SRC2
				curl -o $DEST3 $SRC3
			fi
		fi
		if ! [ -f $DEST ] ; then
			echo >&2 "install-skin: download failed"
			exit 1
		fi
		if ! [ -f $DEST1 ] ; then
			echo >&2 "install-skin: download failed"
			exit 1
		fi
		if ! [ -f $DEST2 ] ; then
			echo >&2 "install-skin: download failed"
			exit 1
		fi
		if ! [ -f $DEST3 ] ; then
			echo >&2 "install-skin: download failed"
			exit 1
		fi
		mv /tmp/skin.xml /usr/share/enigma2/Cyber_fhd/skin.xml
		echo "updated skin.xml..."
		mv /tmp/skin_default.xml /usr/share/enigma2/Cyber_fhd/skin_default.xml
		echo "updated skin_default.xml..."
		mv /tmp/skin_templates.xml /usr/share/enigma2/Cyber_fhd/skin_templates.xml
		echo "updated skin_templates.xml..."
		mv /tmp/skin_templates_default.xml /usr/share/enigma2/Cyber_fhd/skin_templates_default.xml
		echo "updated skin_templates_default.xml..."
		exit 0
	;;
	components)
		SRC="https://raw.githubusercontent.com/Dima73/CyberFHD/master/components/enigma2-plugin-extensions-skin-lib-all-current.ipk"
		DEST=/tmp/enigma2-plugin-extensions-skin-lib-all-current.ipk
		if which curl >/dev/null 2>&1 ; then
			curl -o $DEST $SRC
		else
			echo >&2 "install-components: cannot find curl"
			opkg update && opkg install curl
			if which curl >/dev/null 2>&1 ; then
				curl -o $DEST $SRC
			fi
		fi
		if ! [ -f $DEST ] ; then
			echo >&2 "install-components: download failed"
			exit 1
		else
			opkg install -force-overwrite -force-downgrade /tmp/enigma2-plugin-extensions-skin-lib-all-current.ipk
		fi
		exit 0
	;;
	*)
		echo " "
		echo "Options: $0 {skin|components}"
		echo " "
esac

echo "Done..."

exit 0

