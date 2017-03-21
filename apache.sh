clear

user=`whoami`

if [ $user = "root" ]
then
ch="y"

while [ $ch="y" ]
do

tput cup 4 20
echo "APACHE WEBSERVER"

tput cup 7 20
echo "(1)Creating a New Virtual Server"

tput cup 8 20
echo "(2)Start Apache Server"

tput cup 9 20
echo "(3)Restart Apache Server"

tput cup 10 20
echo "(4)Stop Apache Server"

tput cup 11 20
echo "(5)Authentication"

tput cup 12 20
echo "(6)Check Config File"

tput cup 13 20
echo "(Q)Quit"

tput cup 14 20
echo "Enter choice"
read choice

case $choice in

1)
clear
tput cup 0 0
echo "Enter specific address :"
read ip

tput cup 2 0
echo "Add Name Virtual Server address? (Y/N)"
read ans

case $ans in

	Y)
echo "NameVirtualHost $ip" >> /etc/httpd/conf/httpd.conf
echo "Added !"
#read -n 1
;;

	N)
tput cup 4 0
echo "Enter further details"
#read -n 1
;;

esac

tput cup 6 0
echo "PORT : "
tput cup 8 0
echo " (D)Default   (A)Any    (S)Specific "
read ans

case $ans in

	D)
echo " <VirtualHost $ip> " >> /etc/httpd/conf/httpd.conf
#read -n 1
;;

	A)
echo " <VirtualHost $ip:*> " >> /etc/httpd/conf/httpd.conf
#read -n 1
;;

	S)
echo "Enter specific Port"
read port
echo " <VirtualHost $ip:$port>" >> /etc/httpd/conf/httpd.conf
#read -n 1
;;

esac

tput cup 10 0
echo "Enter Document Root (eg: /www/docs/dummy-hodt.example.com"
read doc
echo "DocumentRoot $doc" >> /etc/httpd/conf/httpd.conf

tput cup 11 0
echo "Enter Server Admin (eg:webmaster@dummy-host.example.com"
read admin
echo "ServerAdmin $admin">> /etc/httpd/conf/httpd.conf

tput cup 12 0
echo "Enter Server Name (eg: dummy-host.example.com)"
read name
echo "ServerName $name" >> /etc/httpd/conf/httpd.conf

tput cup 14 0
echo "Do You want to add logs? (Y/N)"
read ans
case $ans in

	Y)
echo "Enter Error Log (eg: logs/dummy-host.example.com-error_log)"
read elog
echo "ErrorLog $elog" >> /etc/httpd/conf/httpd.conf

echo "Enter Custom Log (eg: logs/dummy-host.example.com-access_log common)"
read clog
echo "CustomLog $clog" >> /etc/httpd/conf/httpd.conf
echo "</VirtualHost>" >> /etc/httpd/conf/httpd.conf

clear
echo "Sending you back to Main Menu"
sleep 5
sh /mrittika/server_mng/apache.sh
;;

	N)
echo "</VirtualHost>" >> /etc/httpd/conf/httpd.conf
clear
echo "Sending you back to Main Menu"
sleep 5
sh /mrittika/server_mng/apache.sh
;;
esac
;;

2)
clear
service httpd start
tail /etc/httpd/conf/httpd.conf
;;

3)
clear
service httpd restart
tail /etc/httpd/conf/httpd.conf
;;

4)
clear
service httpd stop
tail /etc/httpd/conf/httpd.conf
;;

5)
clear
sh /mrittika/server_mng/apache_auth.sh
;;

6)
clear
cat /etc/httpd/conf/httpd.conf | less
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
sh /mrittika/server_mng/apache.sh
clear
;;


esac
done

else
tput cup 4 20
echo "You Must Be ROOT"

fi
