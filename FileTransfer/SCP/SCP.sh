#!/bin/bash



scp /home/user/myfile.txt user1@10.253.104.62:~/myrenamedfile.txt

scp -r /home/user/ user1@10.253.104.62:~/myrenamedfile.txt #-r=recursive folders

scp -r -q /home/user/ user1@10.253.104.62:~/myrenamedfile.txt #-q=quiet

scp -v /home/user/ user1@10.253.104.62:~/myrenamedfile.txt #-v=verbose

scp -i ~/.ssh/mykey.pem /home/user/myfile.txt user1@10.253.104.62:~/myrenamedfile.txt

scp user1@10.253.104.62:~/myrenamedfile.txt /home/user/myfile.txt #copy from a remote location

