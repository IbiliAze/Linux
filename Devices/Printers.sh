#!/bin/bash



[ Printers ]

sudo systemctl emable --now cups

sudo apt install hplip #protocol for hp printers

localhost:631 #cups web gui
    > Adminstration
        > Add Printer

lp -d My_Printer ./test.txt #-d destination, into printer queue (line print)

lpstat -p My_Printer #printer queue and stats

cancel #cancels print jobs
