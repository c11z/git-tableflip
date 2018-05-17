#!/bin/bash
#set -x
#set -e

tableflip_animation () {
    echo -en "(゜-゜)       ┬─┬﻿" "\r"
    sleep 0.5
    echo -en "   (゜-゜)    ┬─┬﻿" "\r"
    sleep 0.5
    echo -en "      (゜-゜) ┬─┬﻿" "\r"
    sleep 1
    echo -en "     (\゜-゜)\┬─┬﻿" "\r"
    sleep 1
    echo "      ( ╯°□° )╯ ┻━┻"
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

    # make workplace
    mkdir -p ${TABLE_FLIP_DIR}

    # backup
    cp -R "$PWD" "${TABLE_FLIP_DIR}/${BASE}_${TIMESTAMP}_backup"

    # clone a clean version of .git files
    git clone -q "$REMOTE" "${TABLE_FLIP_DIR}/${BASE}"

    # remove local dot gitness
    rm -rf "${PWD}/.git"

    # dance of the tableflip
    tableflip_animation

    #replace dot gitness with clean representation
    cp -R ${TABLE_FLIP_DIR}/${BASE}/.git ${PWD}/

    # after success remove clean clone from temp
    rm -rf ${TABLE_FLIP_DIR}/${BASE}

    # echo happy strong emoji
}

alias git="git_or_flip"

