#!/bin/bash



tar cvzf /home/ibi/backup.tgz /home/ibi #c add things to an archive, v verbose, z zip, f file name
tar xvzf /home/ibi/backup.tgz /home/ibi/restore #restore the files
dar -R /home/ibi -c /home/ibi/full.bak #-R recursively point to a folder [FULL BACKUP]
dar -R /home/ibi -c /home/ibi/incr1.bak -A /home/ibi/full.bak #-A pointing to the full backup and we add the incremental changes to that file [INCREMENTAL BACKUP], running this again will be a differential backup
dar -R /home/ibi -c /home/ibi/incr2.bak -A /home/ibi/incr1.bak # carry on with the incremental backup 
dar -x /home/ibi/incr2.bak -w #-w restoring on top of some data
sudo dd if=/dev/sdb1 of=/dev/sdd1 #if input file, of output file, backing up a disk/partition
sudo sestatus