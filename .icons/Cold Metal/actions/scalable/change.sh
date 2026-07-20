for x in $*
do
sed -e "s/#ffffff/#c0caf5/g" $x > temp$x
mv temp$x $x
done
