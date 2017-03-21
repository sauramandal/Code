clear

declare -a files

user=`whoami`
if [ "$user="root"" -o "$user -ne "root"" ]
then
ch="y"

while [ $ch = "y" ]
do
tput cup 4 20
echo " (1) Count WORDS "
tput cup 5 20
echo " (2) Count LINES "
tput cup 6 20
echo " (3) Count CHARACTERS "
tput cup 7 20
echo " (P) Previous Menu "
tput cup 8 20
echo " (Q) Quit"
tput cup 9 20
echo "Enter your choice"
read choice

case $choice in

1)
echo "Do you want to count for multiple files ? (Y/N) "
read ans
case $ans in

Y)
echo " Enter absolute path of filenames separated by space"
read -a files

for i in "${files[@]}"
do
wc -w $i
done

read -n 1
sh /mrittika/file_mng/file3.sh
clear
;;

N)
echo " Enter absolute path filename "
read file
wc -w $file
read -n 1
sh /mrittika/file_mng/file3.sh
clear
;;

esac
clear
;;

2)
echo "Do you want to add multiple files? (Y/N)"
read ans

case $ans in

Y)
echo " Enter absolute path of filenames separated by space"
read -a files

for i in ${files[@]}
do
wc -l i
done

read -n 1
clear
sh /mrittika/file_mng/file3.sh
;;

N)
echo " Enter absolute path filename "
read file
wc -l $file

read -n 1
clear
sh /mrittika/file_mng/file3.sh
;;

esac
clear
;;

3)
echo "Do you want to add multiple files ? (Y/N)"
read ans

case $ans in

Y)
echo "Enter the absolute path of filenames separated by space"
read -a files
for i in ${files[@]}
do
wc -c i
done
read -n 1
clear
sh /mrittika/file_mng/file3.sh
;;

N)
echo "Enter absolute path of filename"
read file
wc -c $file
read -n 1
clear
sh /mrittika/file_mng/file3.sh
;;

esac
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

p)
clear
sh /mrittika/file_mng/file.sh
;;

P)
clear
sh /mrittika/file_mng/file.sh
;;
*)
echo "INVALID CHOICE"
clear
;;

esac
done
fi
