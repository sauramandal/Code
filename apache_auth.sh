clear
ch="y"
while [ $ch = "y" ]
do

tput cup 4 20
echo "(1)Main Server Authentication"
tput cup 5 20
echo "(2)User Authentication"
tput cup 6 20
echo "(P)Previous Menu"
tput cup 7 20
echo "(Q)Quit"
tput cup 8 20
echo "Enter your choice"
read choice

case $choice in

1)
clear

tput cup 0 20
echo "Main Server Authentication"
user=`whoami`
if [ $user = "root" ]
then

tput cup 2 0
echo "Enter the path of the directory to be secured"
echo "The authorisation files must not be located inside the DocumentRoot structure"
read path
echo "<Directory "$path" >" >> /etc/httpd/conf/httpd.conf

tput cup 5 0
echo "Enter AuthType (eg: basic)"
read type

tput cup 7 0
echo "Enter AuthName"
read name

tput cup 9 0
echo "Enter path of AuthUserFile under /etc/httpd/conf (eg: /etc/httpd/conf/authusers"
read pathf

tput cup 11 0
echo "Enter path of AuthGroupFile under /etc/httpd/conf (eg: /etc/httpd/conf/authgroups"
read pathg

tput cup 13 0
echo "Enter name of the Logical Group from AuthGroupFile which will be allowed access"
read lg
echo "AuthType $type
      AuthName "$name"
      AuthUserFile $pathf
      AuthGroupFile $pathg
      Require group $lg
      Options Indexes FollowSymLinks
      AllowOverride None
      </Directory>" >> /etc/httpd/conf/httpd.conf

clear

tput cup 2 0 
echo "Creating AuthGroupFile"
echo "Enter name of the AuthGroupFile as entered in /etc/httpd/conf/httpd.conf"
read pathg
touch /etc/httpd/conf/$pathg
echo "Enter group name and corresponding users in the file and hence save"
echo "(eg private : foo bar choc)"
cat >> /etc/httpd/conf/$pathg

echo "AuthGroupFile created!!"

read -n 1
clear

tput cup 2 0
echo "Creating AuthUserFile"
echo "Enter name of the AuthUserFile as entered in /etc/httpd/conf/httpd.conf"
read pathf
touch /etc/httpd/conf/$pathf
echo "For how many users do you want to make an entry in the file?"
read num

for i in `seq $num`
do
echo "Enter the username"
read i
htpasswd /etc/httpd/conf/$pathf $i
done
echo;
echo "AuthUserFile created!!"

else
echo "You Need To Be Root"
fi
read -n 1
sh /mrittika/server_mng/apache_auth.sh
;;

2)
clear
tput cup 0 20
echo "User Authenticaton"
user=`whoami`
if [ $user != "root" ]
then
tput cup 2 0
echo "Enter path of the directory to be secured"
read path

tput cup 4 0
echo "Enter AuthType (eg: basic)"
read type

tput cup 6 0
echo "Enter AuthName (eg: Alice's Private Directory)"
read name

tput cup 8 0
echo "Enter AuthUserFile (eg: .htauthusers)"
read file

clear
tput cup 2 0
echo "Creating Access File"
touch $path/.htaccess
echo "AuthType $type
      AuthName $name
      AuthUserFile $file
      Require valid-user" >> $path/.htaccess
echo "Access File created !"
read -n 1

clear
tput cup 2 0
echo "Creating AuthUserFile"
touch $path/$file
htpasswd $file $user
echo "AuthUserFile created !"
read -n 1
sh /mrittika/server_mng/apache_auth.sh
fi
;;

P)
clear
sh /mrittika/server_mng/apache.sh
;;

p)
clear
sh /mrittika/server_mng/apache.sh
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
sh /mrittika/server_mng/apache_auth.sh
;;
esac
done



