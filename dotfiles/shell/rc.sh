#!/bin/bash

# personal customized command
if ! [[ "${PATH}" =~ "${HOME}/.local/bin:" ]]; then
    PATH="${HOME}/.local/bin:${PATH}"
fi
if ! [[ "${PATH}" =~ "${HOME}/.local/scripts:" ]]; then
    PATH="${HOME}/.local/scripts:${PATH}"
fi
export PATH

HISTSIZE=10000
shLevel+=" >"
export shLevel

alias ls="ls --color"
alias ll="ls -l"
move() { mv --backup=t $*; }
copy() { cp --backup=t $*; }
trash() { gio trash $*; }
edit() {
    if [[ ! -z "$@" ]]; then
        ${VISUAL} "$@"
    elif type fzf > /dev/null; then
        tempfile="$(mktemp -t tmp.XXXXXX)"
        fzf > "${tempfile}" && ${VISUAL} "$(cat -- ${tempfile})"
    fi
}

go() {
    if type ranger > /dev/null; then
        tempfile="$(mktemp -t tmp.XXXXXX)"
        ranger --choosedir="$tempfile" "${@:-$(pwd)}" --cmd="chain map <cr> quit; set colorscheme snow"
        test -f "$tempfile" &&
            if [ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]; then
                cd -- "$(cat "$tempfile")"
            fi
            rm -f -- "$tempfile"
    fi
}

title() { echo -ne "\e]0;$*\a"; }
alias fzf="fzf -m --border --info=inline"
if   type nvim > /dev/null; then export VISUAL="$(which nvim)"
elif type vim  > /dev/null; then export VISUAL="$(which vim)"; fi
ide() {
    if jobs | grep -q "\${IDE}"; then
        fg $(jobs | grep "\${IDE}" | awk -F'[][]' '{print $2}')
    else
        go
        IDE=${VISUAL}
        if [[ -f "Session.vim" ]]; then
            ${IDE} -S Session.vim
        else
            ${IDE}
        fi
    fi
}

getStatus()
{
    errVal=$?
    retVal=""
    if [[ $[errVal] -ne 0 ]]; then
        retVal=", ERROR:${errVal}"
    fi
    jobStat=""
    jobCount=$[$(jobs | grep -c "\[")]
    if [[ $[jobCount] -gt 0 ]]; then
        jobStat=" ${jobCount} job"
        if [[ $[jobCount] -gt 1 ]]; then
            jobStat="${jobStat}s"
        fi
        jobStat=", ${jobStat}"
    fi
    myPath=${PWD/~/\~}
    if $(git rev-parse --is-inside-work-tree 2>/dev/null); then
        gitBranch="($(git rev-parse --abbrev-ref HEAD 2>/dev/null))"
    else
        gitBranch=""
    fi

   #width=80
    width=${COLUMNS}
    hostStr=" $(test $SSH_TTY && printf 'SSH:')${HOSTNAME%%.*}"
    pathStr="${shLevel} ${myPath}${gitBranch}"
    signalStr="${retVal}${jobStat}"
    timeStr="$(date +%T)"

    diff="$(expr ${width} - length "${hostStr}${pathStr}${signalStr}  ${timeStr} ")"
    if [[ $diff -gt 0 ]]; then
        padding=$(printf %${diff}s)
    else
        padding=""
        myPath=$(printf "%s" "${myPath}" | tail -c +$(expr 1 - ${diff}))
    fi

    tput dim
    tput smul
    printf "\n%s" "${hostStr}${pathStr}${signalStr}${padding}  ${timeStr} "
    tput sgr0
    printf "\n"
}

