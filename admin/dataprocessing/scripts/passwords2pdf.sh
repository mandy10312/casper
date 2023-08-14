#!/bin/tcsh -f

setenv FNAME $1
cd /var/www/html/casper/admin/dataprocessing/raw
latex $FNAME >> /dev/null

setenv BASE `echo $FNAME | sed -e 's+.tex++'`
dvips $BASE.dvi -o $BASE.ps >> /dev/null
ps2pdf $BASE.ps >> /dev/null

rm -f /var/www/html/casper/admin/dataprocessing/processed/$BASE.pdf
mv -f $BASE.pdf /var/www/html/casper/admin/dataprocessing/processed
# rm -f $BASE.*

