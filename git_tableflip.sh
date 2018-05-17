#!/bin/bash
set -ex

tableflip_animation () {
    echo -en "  (゜-゜)       ┬─┬﻿" "\r"
    sleep 1
    echo -en "     (゜-゜)    ┬─┬﻿" "\r"
    sleep 0.5
    echo -en "        (゜-゜) ┬─┬﻿" "\r"
    sleep 1
    echo -en "       (\゜-゜)\┬─┬﻿" "\r"
    sleep 1
    echo "        ( ╯°□° )╯ ┻━┻"
    sleep 1.5
}

haiku_animation () {
    echo "Sadness was your git."
    sleep 1
    echo "Tableflip is the answer."
    sleep 1
    echo "You are git master."
    sleep 1
}

git_or_flip () {
    if [ "$1" == "tableflip" ]
    then
        git_tableflip
    else
        git "$@"
    fi
}


git_tableflip () {
    TABLE_FLIP_DIR="/tmp/git-table-flip"
    BASE=$(basename $PWD)
    REMOTE=$(git config --get remote.origin.url)
    TIMESTAMP=$(date +"%s")

    # if REMOTE empty exit 1
    if [[ -z "$REMOTE" ]]
    then
        echo "There is no remote git repository with which to flip"
        exit 1
    fi

    # make a workplace for doing our stuff
    mkdir -p ${TABLE_FLIP_DIR}

    # create a backup of the user's code (just in case)
    cp -R "$PWD" "${TABLE_FLIP_DIR}/${BASE}_${TIMESTAMP}_backup"

    # clone a clean version of the user's repo (to get its .git files)
    git clone -q "$REMOTE" "${TABLE_FLIP_DIR}/${BASE}"

    # remove local messed up dot gitness
    rm -rf "${PWD}/.git"

    # dance of the tableflip
    tableflip_animation

    # replace messed up dot gitness with clean representation
    cp -R ${TABLE_FLIP_DIR}/${BASE}/.git ${PWD}/

    # after success remove clean clone from temp
    rm -rf ${TABLE_FLIP_DIR}/${BASE}

    # words of wisdom
    haiku_animation
}

alias git="git_or_flip"
