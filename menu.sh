clear
user=`whoami`

if [ $user = "root" ]
then
ch="y"

while [ $ch = "y" ]
do
tput cup 4 20
echo "SERVER ADMINISTRATION"
tput cup 6 20
echo "(1)APACHE SERVER"
tput cup 8 20
echo "(2)DHCP SERVER"
tput cup 10 20
echo "(3)DNS SERVER"
tput cup 12 20
echo "(Q)QUIT"
tput cup 14 20
echo "Enter your choice"
read ans

case $ans in

(1)
sh /mrittika/server_mng/apache.sh
;;

(2)
sh /mrittika/server_mng/dhcp.sh
;;

(3)
sh /mrittika/server_mng/dns.sh
;;

(Q)
exit
clear
;;

(q)
exit
clear
;;

*)
echo "INVALID CHOICE"
sh /mrittika/server_mng/menu.sh
clear
;;

esac
done

else
tput cup 4 20
echo "YOU MUST LOG IN AS ROOT"
fi
