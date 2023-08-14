#!/bin/csh -f

echo "Entering phase 1"
cd phase1
rm -f *

echo "Entering raw"
cd ../
cd raw

foreach file (`ls *.pdf *.PDF`)

   echo "Processing $file"
   setenv basefile `echo $file | sed -e 's/\.*//'`

   echo "Determining pagecount from $file"
   setenv pages `pdfinfo $file | grep Pages | sed -e 's/.*: *//'`

   set p = 1
   while ($p <= $pages) 
     echo "Extracting page $p from $file"

    pdftotext -layout -f $p -l $p $file ./tmp
    setenv regcode `grep RegCode ./tmp | sed -e 's/RegCode //' -e 's/ .*//'`
    setenv year `cat ./tmp | grep Roster | grep Inquiry | sed -e 's/  */ /g' | cut -f8 -d' '`
    setenv semesterlong `cat ./tmp | grep Roster | grep Inquiry | sed -e 's/  */ /g' | cut -f7 -d' '`

    setenv semester "??"
    if ($semesterlong == "Fall") then
	setenv semester "FA"
    else if ($semesterlong == "Spring") then
	setenv semester "SP"
    else
        setenv semester "SU"
    endif

    echo "Processing $year, $semester semester, course $regcode"
    mv tmp ../phase1/$year-$semester-$regcode.txt
    
     @ p = $p + 1
   end

end

cd ..
