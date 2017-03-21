clear

user=`whoami`

if [ $user = "root" ]
then
ch="y"

while [ $ch = "y" ]
do
clear
tput cup 0 20
echo "Configuration Menu"
tput cup 2 0
echo "Can clients update on their own?"
echo "A - Allow ; D - Deny ; I - Ignore"
read ans
case $ans in
	A)
	echo "ddns-update-style none ;
       	      allow client updates ;" >> /etc/dhcpd.conf
		;;

	D)
	echo "ddns-update-style none;
      	deny client updates;" >> /etc/dhcpd.conf
	;;

	I)
	echo "ddns-update-style none;
      	ignore client updates;">> /etc/dhcpd.conf
	;;
	
	*)
	echo "Enter valid choice"
	sh /mrittika/server_mng/dhcp_conf.sh
	;;
	esac
tput cup 5 20
echo " Enter Subnetwork details"
echo " Enter Subnetwork Description"
read sdesc
echo " Enter Subnet"
read subnet
tput cup 10 0
echo " Enter Netmask"
read netmask
tput cup 12 0
#echo "Enter the range of ip addresses the server will issue to DHCP clients"
#echo "Enter start ip address"
#read start
#echo "Enter end ip address"
#read end
tput cup 17 0
echo "Enter time in seconds that client may keep the IP address"
echo "Enter default lease time"
read default
tput cup 20 0
echo "Enter max lease time"
read max
tput cup 22 0
echo "Enter the option domain name"
read domain
echo "lease-file-name "/var/lib/dhcpd/dhcpd.leases";
      option domain-name	"$domain";
      default-lease-time	 $default;
      max-lease-time		 $max;" >> /etc/dhcpd.conf

tput cup 24 0
echo "Enter Host Description"
read hdesc
tput cup 26 0
echo "Enter Hostname"
read host
tput cup 28 0
echo "Enter Hardware Type (eg : ethernet ; fddi ; token-ring)"
read type
tput cup 30 0
echo "Enter Hardware Address"
read hadd
tput cup 32 0
echo "Enter fixed ip address"
read fip

echo "#hdesc
      host $host {
      hardware $type $hadd;
      fixed-address $fip;
       }" >> /etc/dhcpd.conf
read -n 1
clear

tput cup 5 20
echo "Expanding dhcpd.conf file"
declare -a srange
declare -a erange
echo "Enter the range of ip addresses the server will issue to the DHCP clients"
echo "How many ranges do you want to provide for the above subnet? (number of start=end)" 
echo "Enter start ip addresses with space between each"
read -a srange
echo "Enter end ip addresses with space between each"
read -a erange
#echo

e_count=${#erange[@]}
s_count=${#srange[@]}

num=0
echo "subnet $subnet netmask $netmask {
      " >> /etc/dhcpd.conf
while [ $num -lt $s_count -a $num -lt $e_count ]
do
#echo "Enter the start ip"
#read -a ${srange[$num]}
#echo "Enter the end ip"
#read -a ${erange[$num]}
echo "range ${srange[$num]} ${erange[$num]};">>/etc/dhcpd.conf
((num++))
done
echo "Expanding done"
read -n 1
clear

tput cup 5 20
echo "Adding Options"
#declare -a options
echo "subnet $subnet netmask $netmask { " >> /etc/dhcpd.conf
opt()
{
echo "Enter the complete option name"
echo "There are following options available :"
echo " (1)host-name"
echo " (2)domain-name"
echo " (3)subnet-mask"
echo " (4)routers"
echo " (5)domain-name-servers"
echo " (6)netbios-name-servers"
echo " (7)ip-forwarding"
read opts

#echo "subnet $subnet netmask $netmask { " >> /etc/dhcpd.conf

if [ $opts == "host-name" -o $opts == "domain-name" ]
then 
echo "Enter the string name"
read string
echo " option $opts $string ; " >> /etc/dhcpd.conf

else if [ $opts == "subnet-mask" -o $opts == "routers" -o $opts == "domain-name-servers" -o $opts == "netbios-name-servers" -o $opts == "ip-forwarding" ]
then
echo "Enter ip address"
read ip
echo " option $opts $ip ; " >> /etc/dhcpd.conf
fi
fi
#echo "}" >> /etc/dhcpd.conf
echo "Option Added"
}
ask()
{
echo "Do you want to add more options? (Y/N)"
read res
if [ $res == "Y" ]
then
opt
ask
else if [ $res == "N" ]
then
echo " } " >> /etc/dhcpd.conf
echo "Options added !!"
fi
fi

read -n 1
echo "Enter Q to quit"
read q
if [ $q = "Q" ]
then
exit

clear
fi
}
ask

done

else
echo "You Need To Be ROOT"
fi
