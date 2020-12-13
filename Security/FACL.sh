#!/bin/bash



getfacl test.txt #get all permission details of a file
setfacl -m test.txt 
setfacl -m o::r test.txt #-m modify, o other, :: no particular user
setfacl -m u:ibi:rw test.txt #u user
setfacl -m g:group1:rwx test.txt #g group
setfacl -m d:g:group1:rw test.txt #d directory
setfacl -x u:ibi test.txt #remove permissions
setfacl -b test.txt #blast, remove all permissions
setfacl -m m::rx test.txt #modify the mask
setfacl -Rm d:u:ibi:rx adir #-R recursive, d default

