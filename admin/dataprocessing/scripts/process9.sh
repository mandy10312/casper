#!/bin/csh -f

cd /var/www/html/casper/admin/dataprocessing/

setenv BASE `echo $1 | sed -e 's+.pdf++' | sed -e 's+.PDF++'`
setenv FNAME "$BASE.log"

echo "**********    "`date` >> logs/$FNAME
echo "**********    Moving raw/* to processed" >> logs/$FNAME
mv -f ./raw/*.pdf ./raw/*.PDF processed 

echo "**********    "`date` >> logs/$FNAME
echo "**********    Cleaning out phase1/*" >> logs/$FNAME
rm -f ./phase1/* 

echo "**********    "`date` >> logs/$FNAME
echo "**********    Cleaning out phase2/*" >> logs/$FNAME
rm -f ./phase2/* 

echo "logs/$FNAME"

