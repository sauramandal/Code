
clear

user=`whoami`

if [ $user = "root" ]
then
ch="y"

while [ $ch = "y" ]
do
tput cup 0 20
echo "CREATING MASTER ZONE"
tput cup 1 0
echo " (P) Previous Menu"
tput cup 2 0
echo " (Q) Quit"
tput cup 3 0
echo " (R) Read named.conf file"
tput cup 4 0
echo " (C) Continue"
tput cup 5 0
echo "Enter your choice"
read choice

case $choice in

P)
clear
sh /mrittika/server_mng/dns.sh
;;

Q)
exit
clear
;;

R)
cat /etc/named.conf | less
read -n 1
clear
sh /mrittika/server_mng/master.sh
;;

C)
	clear
	tput cup 1 0
	echo "Do you want to add FORWARD (F) or REVERSE (R) zone?"
	read zone
	case $zone in
	
	F)
	clear
	tput cup 4 0
	echo "Enter Domain Name (eg: abc.com)"
	read domain
	
	tput cup 6 0
	echo "Enter file (eg:abc.com)"
	read file
	;;

	R)
	clear
	tput cup 3 0
	echo "Enter Domain with first three octets in reverse order (eg: for 192.168.1.0/24 network domain will be 1.168.192.in-addr.arpa"
	read domain
	
	tput cup 5 0
	echo "Enter file (eg: 192.168.1)"
	read file
	;;
	
	*)
	clear
	tput cup 3 0
	echo "Enter F or R"
	read -n 1
	clear
	sh /mrittika/server_mng/master.sh
	;;
	esac

tput cup 8 0
echo "Enter Email address (eg: xyz (for xyz@abc.com))"
read email

tput cup 10 0
echo "Enter Name Server (eg: server1 )"
read ns

tput cup 12 0
echo "Enter ip of website"
read ip

tput cup 14 0
echo "Do you want to allow-query (Y/N)"
read ans

	case $ans in

	Y)
	tput cup 16 0
	echo "Enter ip to define a network allowed to query your DNS server (eg: 192.168.2.0/24)"
	echo "Type "any" if you want to allow any network"
	read ip

		echo "zone "$domain" IN {
      		type master;
	       	file "/var/named/$file.zone";
      		allow-update {none;};
      		allow-query  {$ip; };
		};" >> /etc/named.conf
	
		echo "Entry made in named.conf"
		read -n 1
		clear
		;;
	N)
		echo "zone "$domain" IN {
   		type master;
      		file "/var/named/$file.zone";
      		allow-update {none;};
      		};" >> /etc/named.conf
		
		echo "Entry made in named.conf"
		read -n 1
		clear
		;;
	esac

tput cup 2 0
echo "Do you want to edit zone file (Y/N)?"
read res
	case $res in
	Y)
		ls /var/named/chroot/var/named/
		echo "Enter the zone file"
		read zfile
		cat /var/named/chroot/var/named/$zfile | less
		read -n 1
		clear	
		
		tput cup 2 0
		echo "Enter TTL value.The default value is 3D.In absence of suffix BIND cosiders it in seconds"
		echo "D - Days ; H - Hours ; W - Weeks"
		read ttl
		
		tput cup 5 0
		echo "Enter the zone.The "@" is used as a reference to the current zone in the /etc/named.conf file for that particular database file."
		read zone
		clear

		func()
		{
			tput cup 1 0
			echo "Enter the Type of record (eg: SOA ; NS ; MX ; A ; CNAME ; PTR) "
			read type
				case $type in

				SOA)
					tput cup 4 0
					echo "Enter Serial-no (eg: 2004100801 . You can use YYYYMMDD with an incremented single digit number at the end) "
					read serial

					tput cup 6 0
					echo "Enter Refresh time (eg: 4H)"
					read refresh

					tput cup 8 0
					echo "Enter Retry time (eg: 1H)"
					read retry

					tput cup 10 0
					echo "Enter Expiry time (eg: 1W)"
					read expiry

					tput cup 12 0
					echo "Enter Minimum TTL (eg: 1D)"
					read min
					
					read -n 1
					clear
					;;
				NS)
					;;
				esac
			}
		echo "Do you want to add more Types (Y/N)?"
		read ans
			case $ans in
			Y)
			clear
			func
			clear
			;;

			N)
			clear
			;;
			
			esac
			

		#	tput cup 2 0
		#	echo "Enter TTL value. Default is 3D.In absence of suffix BIND considers the value is in seconds"
		#	echo "D - Days ; W - Weeks ; H - Hours"
		#	read ttl

		#	tput cup 5 0
		#	echo "Enter Name of zone.The "@" sign is a reference to the current zone in /etc/named.conf file for that particular database file"
		#	read zone
			;;
							
		  	
	N)
		ls /var/named/chroot/var/named/
		echo "Enter the zone file"
		read zfile
		cat /var/named/chroot/var/named/$zfile | less
		read -n 1
		clear	
		;;
	esac	
;;
esac
echo "Enter Q to quit or C to check named.conf file"
read quit

	case $quit in

	Q)
	clear
	ch="n"
	;;

	C)
	cat /etc/named.conf | tail
	read -n 1
	clear
	;;
	esac
	
	done
	
	else
	echo "You Need To Be ROOT"
	fi
