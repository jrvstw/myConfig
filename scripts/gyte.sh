#!/bin/bash

gyteDir=${HOME}/gyte

_gyte()
{
    printf "\n$(tput dim)$(git rev-parse --show-toplevel):$(tput sgr0)\n"

    if [ "$1" == 'save' ]; then
        git add -A && git status && git commit -m "quicksave" && git push
    elif [ "$1" == 'load' ]; then
        git pull && git status
    else
        git $*
    fi
}

workingdir=$1
shift

if [[ "${workingdir}" == '-a' ]]; then
    test -d ${gyteDir} || mkdir -p ${gyteDir}
    find ${gyteDir} -maxdepth 1 -type l -exec gyte.sh '{}' $* \;
elif [[ "${workingdir}" == '' ]]; then
    git
else
    if git -C ${workingdir} rev-parse ; then
        cd ${workingdir} && _gyte $*
    else
        exit 1
    fi
fi

