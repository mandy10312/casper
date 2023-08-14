#!/bin/csh -f

cd phase2
rm -f *

cd ../
cd phase1

foreach file (`ls *.txt`)


setenv regcode `grep RegCode $file | sed -e 's+RegCode *++' -e 's+ .*++'`
setenv dept `grep RegCode $file | sed -e 's+RegCode *++' -e 's+[0123456789]* *++' -e 's+ .*++'`
setenv course `grep RegCode $file | sed -e 's+RegCode *++' -e 's+[0123456789]* *++' -e 's+[A-Z]* *++' -e 's+ .*++'`
setenv section `grep RegCode $file | sed -e 's+RegCode *++' -e 's+[0123456789]* *++' -e 's+[A-Z]* *++' -e 's+.* *Sec *++' -e 's+ .*++'`
setenv coursename `grep RegCode $file | sed -e 's+RegCode *++' -e 's+&+AND+' -e 's+[0123456789]* *++' -e 's+[A-Z]* *++' -e 's+.* *Sec *++' -e 's+[0123456789]* *++' -e 's+ +_+g'`
setenv instructorX `grep Instructors $file | sed -e 's+Instructors: *++' -e 's+ +_+g'`
setenv instructor `echo $instructorX | sed -e 's/\([^_]\)[^_]*_\(.*\)/\2_\1/'`

echo "Processing $file... $dept$course-$section($regcode) $coursename [$instructor]"

set startline = `grep -n "Last Name" $file | sed -e 's+:.*++'`
@ startline = $startline + 1
set students = `grep "Total" $file | sed -e 's+Total: *++'`
@ students = $students

set year = `echo $file | sed -e 's+-.*++'`
set semester = `echo $file | sed -e 's+....-++' -e 's+-.*++'`
set regcode = `echo $file | sed -e 's+.*-++' -e 's+\.txt++'`

set firstcut = $startline
@ firstcut = $firstcut + $students - 1

head -$firstcut $file | tail -$students | sed -e 's+\*\*\*-\*\*-+  +' -e 's+   *+,+g' -e 's+ +_+g' -e 's+$+,NG+' -e "s+\([^,]\)\([^,]*\),\([^,]\)\([^,]*\),\([^,]\)\([^,]*\),\([^,][^,]*\),\([^,][^,]*\),\([^,][^,]*\)+$year,""$semester"",""$dept"",""$course"",""$section"",""$regcode"",""$coursename"",""$instructor"",""\1\3"",""\5\6"",""\1\2"",""\3\4"",""\7"",""\9""+" -e 's+,NG$++' > ../phase2/$file

end

cd ..
