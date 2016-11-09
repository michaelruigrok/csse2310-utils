#!/usr/bin/env bash

files="*.c"

if [ $1 = 'fix' ]; then 

    #If any arguments after 'fix' are present, use them as files
    if [ $# -gt 1 ]; then
	files="$2"
    elif [ "*.c" = '*.c' ]; then
	echo "Error: no C files are present"
	exit
    fi

#Welcome to regex hell :D
	vim -N -u NONE -E \
-c "argdo %s/(\zs\s\ze//ge |
 %s/\zs\s\ze)//ge |
 %s/;\s*/;/ge |
 %s/;\zs\ze\S.\+$/ /ge |
 %s/\S\zs\ze{/ /ge |
 %s/,\zs\ze\S/ /ge |
 %s/\s\zs\ze,//ge |
 %s/=\zs\ze[^= ]/ /ge |
 %s/\w\zs\ze=/ /ge |
 %s/\w\zs\ze!/ /ge |
 w" \
	 -c wq "$files"
else 
    echo "this program makes a heap of changes to your *.c files"
    echo "(or whatever files you specified to edit)"
    echo "Be careful, either understand it or run it on a backup copy,"
    echo "otherwise you use at your own risk."
    echo
    echo "Enter the argument 'fix' to run"
    echo
    echo "Note: If you aren't used to vim regex, \zs and \ze represent the"
    echo "start and end of what will be replaced respectively"

fi
