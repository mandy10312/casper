#!/bin/csh -f

cd /var/www/html/casper/admin/dataprocessing/

setenv BASE `echo $1 | sed -e 's+.pdf++' | sed -e 's+.PDF++'`
setenv FNAME "$BASE.log"

rm -f logs/$FNAME

sleep 3

touch -f logs/$FNAME

echo "**********    "`date`": PLACING LOG IN logs/$FNAME" >> logs/$FNAME
echo " XXX " >> logs/$FNAME
echo "**********    Running raw to phase 1 conversion" >> logs/$FNAME

./scripts/raw2phase1.sh >> logs/$FNAME
echo "**********    Completed" >> logs/$FNAME
