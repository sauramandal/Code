clear

user=`whoami`
if [ "$user = "root" " -o "$user != "root" " ]
then
ch="y"

while [ $ch = "y" ]
do

tput cup 4 20
echo "FILE MANAGEMENT"
tput cup 5 20
echo " (1) List Files "
tput cup 6 20
echo " (2) Create OR View Content "
tput cup 7 20
echo " (3) Counting Words Lines Characters"
tput cup 8 20
echo " (4) Manipulate Files "
tput cup 9 20
echo " (Q) Quit "
tput cup 10 20
echo "Enter Choice"
read choice

case $choice in

1)
sh /mrittika/file_mng/file1.sh
;;

2)
sh /mrittika/file_mng/file2.sh
;;

3)
sh /mrittika/file_mng/file3.sh
;;

4)
sh /mrittika/file_mng/file4.sh
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
echo " INVALID CHOICE "
clear
;;

esac
done
fi
