#!/bin/csh -f

cd /var/www/html/casper/admin/dataprocessing/

setenv BASE `echo $1 | sed -e 's+.pdf++' | sed -e 's+.PDF++'`
setenv FNAME "$BASE.log"

echo "**********    "`date` >> logs/$FNAME
echo "**********    Running phase1 to phase 2 conversion" >> logs/$FNAME
./scripts/phase12phase2.sh >> logs/$FNAME

cd ./phase2
cat *.txt > 00temp.dat
cd ..

