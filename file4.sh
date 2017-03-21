clear
func()
{
echo "Source should not be a directory."
echo "Source must exist."
echo "If Destination is a directory then all the source files will be copied under that directory with same names."
}
declare -a files
user=`whoami`
if [ "$user="root"" -o "$user -ne "root"" ]
then
ch="y"

while [ $ch = "y" ]
do
tput cup 4 20
echo " (1) Copy Files"
tput cup 5 20
echo " (2) Remove Files"
tput cup 6 20
echo " (3) Rename Files"
tput cup 7 20
echo " (P) Previous Menu"
tput cup 8 20
echo " (Q) Quit"
tput cup 9 20
echo "Enter your choice"
read choice

case $choice in

1)
echo "Do you want to give multiple source? (Y/N)"
read ans
case $ans in

Y)
func
echo "Enter absolute path of sources separated by space"
read -a files
echo "Enter absolute path of destination"
read dest
if [ ""$user" -O $dest" -o ""root" -O $dest" ]
then
for i in ${files[@]}
do
cp -i $i $dest
done
fi
echo "Long List $dest"
ls -l $dest

read -n 1
sh /mrittika/file_mng/file4.sh
clear
;;

N)
func
echo "Enter absolute path of source"
read source
echo "Enter absolute path of destination"
read dest
if [ ""$user" -O $dest" -o ""root" -O $dest" ]
then
cp -i $source $dest
echo "Long List $dest"
ls -l $dest
fi
read -n 1
sh /mrittika/file_mng/file4.sh
clear
;;

esac
clear
;;

2)
echo "Files to be removed must exist"
echo "Enter the absolute path of the files to be removed separated by space"
read -a files
if [ ""$user" -O ${files[@]}" -o ""root" -O ${files[@]}" ]
then
for i in ${files[@]}
do
rm -i $i
done
fi
clear
;;

3)
echo "Enter the absolute path of the file to be renamed"
read file
echo "Destination file will be the new name of the source file"
echo "Enter the absolute path of the destination file"
read dest
if [ ""$user" -O $file" -o ""root" -O $file" ]
then
mv -i $file $dest
fi
echo "New file $dest"
ls -l $dest
read -n 1
clear
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
sh /mrittika/file_mng/file4.sh
;;
esac
done
fi
