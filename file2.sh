clear
declare -a files
user=`whoami`
if [ "$user = "root" " -o "$user -ne "root"" ]
then
ch="y"

while [ $ch = "y" ]
do

tput cup 4 20
echo " (1) Create a new file "
tput cup 5 20
echo " (2) View Content "
tput cup 6 20
echo " (3) Edit Content"
tput cup 7 20
echo " (P) Previous Menu"
tput cup 8 20
echo " (Q) Quit "
tput cup 9 20
echo "Enter your choice"
read choice

case $choice in

1)
echo "Do you want to create more than one file? (Y/N)"
read ans
case $ans in

Y)
echo "Enter the names of the files separated by space"
read -a files
for i in ${files[@]}
do
echo "Enter the path where you want to create"
read path
echo "Enter the contents and save"
vi $path/$i
done
#echo "Enter the name of new file"
#read file
#echo "Enter path where you want to create"
#read path
#echo "Enter contents and then save"
#vi $path/$file
read -n 1
clear
sh /mrittika/file_mng/file2.sh
;;

N)
echo "Enter the file name"
read file
echo "Enter path where you want to create"
read path
echo "Enter contents and save"
vi $path/$file
read -n 1
clear
;;

esac
;;

2)
echo "Enter path of the file starting with /"
read path
#touch test1
#chmod 755 test1
#ls -l $path | cut -c 3 | cat > test1
ls -l $path | if [ ""root" -O $path" -o ""$user" -O $path" ]
	      then
cat $path | less

else
echo " $user is not the owner"
fi

read -n 1
rm test1
clear
sh /mrittika/file_mng/file2.sh
;;

3)
echo "Enter the path of the file starting with /"
read path
#if [ $user=`whoami` ]
#then
#touch test1
#chmod 755 test1
ls -l $path | if [ ""root" -O $path" -o ""$user" -O $path" ]
	      then
vi $path

else
echo "$user is not the owner"
fi

read -n 1
rm test1
clear
sh /mrittika/file_mng/file2.sh
;;

P)
clear
sh /mrittika/file_mng/file.sh
;;

p)
clear
sh /mrittika/file_mng/file.sh
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
fi
