#!/bin/csh -f

cd /var/www/html/casper/admin/dataprocessing/

setenv BASE `echo $1 | sed -e 's+.pdf++' | sed -e 's+.PDF++'`
setenv FNAME "$BASE.log"

echo "**********    "`date` >> logs/$FNAME
echo "**********    Processing $FNAME" >> logs/$FNAME

rm -f logs/$FNAME
touch -f logs/$FNAME

echo "**********    "`date` >> logs/$FNAME
echo "**********    Running raw to phase 1 conversion" >> logs/$FNAME
./scripts/raw2phase1.sh >> logs/$FNAME

echo "**********    "`date` >> logs/$FNAME
echo "**********    Running phase1 to phase 2 conversion" >> logs/$FNAME
./scripts/phase12phase2.sh >> logs/$FNAME

cd ./phase2
cat *.txt > 00temp.dat
cd ..

echo "**********    "`date` >> logs/$FNAME
echo "**********    Running load-temp.sql, showing added rows:" >> logs/$FNAME
mysql -u root < ./scripts/load-temp.sql

echo "**********    "`date` >> logs/$FNAME
echo "**********    Running load-course.sql, showing added rows:" >> logs/$FNAME
mysql -u root < ./scripts/load-course.sql

echo "**********    "`date` >> logs/$FNAME
echo "**********    Running load-student.sql, showing added rows:" >> logs/$FNAME
mysql -u root < ./scripts/load-student.sql

echo "**********    "`date` >> logs/$FNAME
echo "**********    Running load-prof.sql, showing added rows:" >> logs/$FNAME
mysql -u root < ./scripts/load-prof.sql

echo "**********    "`date` >> logs/$FNAME
echo "**********    Running load-offering.sql, showing added rows:" >> logs/$FNAME
mysql -u root < ./scripts/load-offering.sql

echo "**********    "`date` >> logs/$FNAME
echo "**********    Running load-registration.sql, showing added rows:" >> logs/$FNAME
mysql -u root < ./scripts/load-registration.sql

echo "**********    "`date` >> logs/$FNAME
echo "**********    Moving raw/* to processed" >> logs/$FNAME
mv -f ./raw/*.pdf processed 
rm -f ./raw/*

echo "**********    "`date` >> logs/$FNAME
echo "**********    Cleaning out phase1/*" >> logs/$FNAME
rm -f ./phase1/* 

echo "**********    "`date` >> logs/$FNAME
echo "**********    Cleaning out phase2/*" >> logs/$FNAME
rm -f ./phase2/* 

echo "logs/$FNAME"

