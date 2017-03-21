clear

user=`whoami`
if [ $user = "root" ]
then
ch="y"

while [ $ch = "y" ]
do
tput cup 4 20
echo "Creating DHCP Server"
tput cup 5 20
echo " (1) Start DHCPD service"
tput cup 6 20
echo " (2) Restart DHCPD service"
tput cup 7 20
echo " (3) Stop DHCPD service"
tput cup 8 20
echo " (C) Configure DHCP Server"
tput cup 9 20
echo " (Q) Quit"
tput cup 10 20
echo "Enter your choice"
read choice

case $choice in

1)
clear
service dhcpd start
read -n 1
sh /mrittika/server_mng/dhcp.sh
;;

2)
clear
service dhcpd restart
read -n 1
sh /mrittika/server_mng/dhcp.sh
;;

3)
clear
service dhcpd stop
read -n 1
sh /mrittika/server_mng/dhcp.sh
;;

C)
echo "sending you to the configuration menu"
sleep 5
sh /mrittika/server_mng/dhcp_conf.sh
;;

Q|q)
exit
clear
;;

*)
clear
echo "INVALID CHOICE"
sh /mrittika/server_mng/dhcp.sh
;;

esac
done

else
echo "YOU MUST BE ROOT"
fi

