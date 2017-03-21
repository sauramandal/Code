clear
declare name
func ()
{
echo "enter username"
read name
touch test1
chmod 777 test1
grep $name /etc/passwd | cat > test1
}

user=`whoami`
if [ $user = "root" ]
then
ch="y"

while [ $ch = "y" ]
do

tput cup 4 20
echo " USER ADMINISTRATION "
tput cup 5 20
echo " (1) Check Existing Users "
tput cup 6 20
echo " (2) Check Specific User "
tput cup 7 20 
echo " (3) Add New User "
tput cup 8 20
echo " (4) Delete User "
tput cup 9 20
echo " (5) Add User To Group "
tput cup 10 20
echo " (Q) Quit "
tput cup 11 20
echo " Enter Your Choice "
read choice

case $choice in

1)
echo " ALREADY EXISTING USERS "
cat /etc/passwd | less
clear
read -n 1
;;

2)
echo " Enter Name Of The User "
read name
touch test1
chmod 777 test1
grep $name /etc/passwd | cat > test1
grep $name /etc/shadow | cat >> test1

if test -s test1
then
echo " USER FOUND "
cat test1
echo "PRESS ANY KEY TO RETURN"
read -n 1
rm test1
sh /mrittika/user_mng/user.sh

else
echo " Please Enter Valid User or Create a New User First "
echo "PRESS ANY KEY TO RETURN"
read -n 1
rm test1
sh /mrittika/user_mng/user.sh
fi
;;

3)
#echo " Enter Username"
#read name
#touch test1
#chmod 777 test1
#grep $name /etc/passwd | cat > test1

func
while test -s test1
do
echo "Username Exists. Try another Username"
func
done

echo "ADDING NEW USER"
 useradd $name
 passwd $name
exit 0
read -n 1
rm test1
clear
;;

4)
echo "Enter User To Be Deleted "
read name
userdel -r $name
clear
;;

5)
echo "Enter Name Of The User"
read name
touch test1
chmod 777 test1
grep $name /etc/passwd | cat > test1

if test -s test1
then
echo "Sending You To The Groups Menu"
rm test1
sleep 5
sh /mrittika/user_mng/groups.sh

else
echo " User Doesnot Exist. Please Create User First"
echo " PRESS ANY KEY TO RETURN"
read -n 1
sh /mrittika/user_mng//user.sh
fi
clear
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
echo " INVALID CHOICE"
clear
;;

esac
done

else
echo "YOU MUST LOGIN AS ROOT"
fi


