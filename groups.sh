clear
user=`whoami`
if [ $user = "root" ]
then
ch="y"

while [ $ch = "y" ]
do
tput cup 4 24
echo " GROUPS MENU "
tput cup 5 20
echo " (1) Check /etc/group "
tput cup 6 20
echo " (2) Check users of a group "
tput cup 7 20
echo " (3) Change User's Primary Group "
tput cup 8 20
echo " (4) Add User to a Secondary Group "
tput cup 9 20
echo " (5) Check Groups of a User "
tput cup 10 20
echo " (6) Go to Previous Menu"
tput cup 11 20
echo " (Q) QUIT"
tput cup 12 20
echo " ENTER YOUR CHOICE "
read choice

case $choice in

1)
cat /etc/group | less
clear
read -n 1
;;

2)
echo " Enter Group Name"
read name
touch test1
chmod 777 test1
grep $name /etc/group | cat > test1

if test -s test1
then
echo " Group Found "
cat test1
echo "PRESS ANY KEY TO RETURN "
read -n 1
rm test1
sh /mrittika/user_mng/groups.sh

else
echo " No such Group "
echo " PRESS ANY KEY TO RETURN "
read -n 1
rm test1
sh /mrittika/user_mng/groups.sh
fi
clear
;;

3)
echo " Enter user "
read user
touch test1
chmod 777 test1
grep $user /etc/passwd | cat > test1

if test -s test1
then
echo "Enter the name of the primary group"
read group
touch test2
chmod 777 test2
grep -w $group /etc/group | cat > test2

if test -s test2
then
echo " BEFORE CHANGING PRIMARY GROUP"
id $user
echo " AFTER CHANGING PRIMARY GROUP"
usermod -g $group $user
id $user

else
echo "No such group"
echo "Do You Want To Create One? (Y/N)"
read ans
case $ans in

Y)
echo "Enter group to be added"
read grp
groupadd $grp
echo "Group added successfully"
cat /etc/group | grep -w $grp
echo "To make this group primary, enter the user"
read user
echo "Before changing Primary group"
id $user
usermod -g $grp $user
echo "After changing primary group"
id $user
echo "PRESS ANY KEY TO RETURN"
read -n 1
sh /mrittika/user_mng/groups.sh
;;

N)
echo "PRESS ANY KEY TO RETURN"
read -n 1
rm test1
sh /mrittika/user_mng/groups.sh
;;

*)
echo "Choice is either Y (YES) or N (NO)"
read -n 1
sh /mrittika/user_mng/groups.sh
clear
;;
esac

rm test2
fi

else
echo "No Such User"
echo "PRESS ANY KEY TO RETURN"
read -n 1
rm test1
fi
clear
;;

4)
echo "Enter user"
read user
touch test3
chmod 777 test3
grep $user /etc/passwd | cat > test3

if test -s test3
then
echo "Enter Secondary Group"
read group
touch test4
chmod 777 test4
grep $group /etc/group | cat > test4

if test -s test4
then
echo "User : groups"
usermod -G $group $user
groups $user

else
echo "No such group"
echo "Do you want to add one? (Y/N)"
read choice

case $choice in

Y)
echo "Enter group to be added"
read group
groupadd $group
echo "Group added successfully"
cat /etc/group | grep -w $group

echo "Enter user"
read user
usermod -G $group $user
echo "User : Groups"
groups $user
echo "PRESS ANY KEY TO RETURN"
read -n 1
sh /mrittika/user_mng/groups.sh
;;

N)
echo "PRESS ANY KEY TO RETURN"
read -n 1
sh /mrittika/user_mng/groups.sh
;;

*)
echo "Choice is either Y (YES) or N (NO)"
read -n 1
sh /mrittika/user_mng/groups.sh
;;
esac

rm test4
fi

else
echo "No such User"
rm test3
echo "PRESS ANY KEY TO RETURN"
read -n 1
fi
clear
;;

5)
echo " Enter User"
read user
touch test3
chmod 777 test3
grep $user /etc/passwd | cat > test3

if test -s test3
then
echo " Groups of $user "
groups $user

echo "PRESS ANY KEY TO RETURN"
read -n 1
rm test3

else
echo "No such User"
sh /mrittika/user_mng/groups.sh
fi
clear
;;

6)
echo "Sending you to the User Menu"
sleep 5
sh /mrittika/user_mng/user.sh
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
echo "You MuST LOGIN AS ROOT"
fi
