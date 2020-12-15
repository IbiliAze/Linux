#!/bin/bash


sudo apt install -y gcc make gzip #compiler
tar xvzf ./file.tar.gz #x extract, v verbose, z unzip, f file name
cd src #source code
cd src; make config #compline from src
make clean linux-x86-64 #clean=full, build a configuration compiler and a binary
sudo make install #take these individual files and put them where they're supposed to go, e.g run/Binary > /usr/bin



