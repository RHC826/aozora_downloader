#!/usr/bin/sh

grep -n "$1" ./output.txt | sed -e 's/[（（][^（）]*[）)]//g' -e  's/\(.*\)/\1\n/'
