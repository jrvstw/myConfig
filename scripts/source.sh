#!/bin/bash

src=$1
dst=$2

if [ ! -f $dst ]; then echo > $dst; fi
grep -q "$src" $dst || printf "$src\n" >> $dst
sed -i "$(grep -n $src $dst | cut -d: -f1)c source $src" $dst

