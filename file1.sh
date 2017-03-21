clear
declare path
file()
{
	echo  "Enter the absolute path starting with / (eg : /etc) "
	read path
}

ch="y"
while [ $ch = "y" ]
do

tput cup 4 20
echo " (1) Long List Files and Directories "
tput cup 5 20
echo " (2) LONG List Hidden Files and Directories"
tput cup 6 20
echo " (P) Previous Menu"
tput cup 7 20
echo " (Q) Quit"
tput cup 8 20
echo "Enter Your choice"
read choice

case $choice in

1)
echo "Items having a / at the end are directories.The other items having no character appended are ordinary files.For special files : ! , @ , #  are appended to the filename."
file
ls -l -F $path
read -n 1
sh /mrittika/file_mng/file1.sh
clear
;;

2)
echo "Invisible file has a dot or period character (.) as the first character.These files are used to store configuration information."
file
ls -l -f -a $path
read -n 1
sh /mrittika/file_mng/file1.sh
clear
;;

P|p)
sh /mrittika/file_mng/file.sh
clear
;;

Q|q)
exit
clear
;;

*)
echo "INVALID CHOICE"
clear
;;

esac
done



