clear
user=`whoami`
if [ $user = "root" ]
then
ch="y"
while [ $ch = "y" ]
do
tput cup 4 20
echo "BIND DNS CONFIGURATION"
tput cup 6 20
echo " (1) Create a Master Zone"
tput cup 7 20
echo " (2) Create a Slave Zone"
tput cup 8 20
echo " (3) Create a Forward Zone"
tput cup 9 20
echo " (Q) Quit"
tput cup 11 20
echo "Enter your choice"
read choice

case $choice in

1)clear
sh /mrittika/server_mng/master.sh
;;

2)
clear
sh /mrittika/server_mng/slave.sh
;;

3)
clear
sh /mrittika/server_mng/forward.sh
;;

Q)
exit
clear
;;

q)
exit
clear
;;

*)
echo "INVALID CHOICE"
clear
;;

esac
done
else
echo "You Must Be ROOT"
fi
