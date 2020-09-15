#!/bin/bash

src=$1
dst=$2

if [ -L ${dst} ]; then unlink ${dst}; fi
if [ -e ${dst} ]; then mv ${dst} ${dst}.default; fi
ln -s $(readlink -f ${src}) $(readlink -f ${dst})

