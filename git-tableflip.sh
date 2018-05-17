#!/bin/bash
#set -x
#set -e

git-or-flip () {
    if [ "$1" == "tableflip" ]
    then
        git-tableflip
    else
        git "$@"
    fi
}


git-tableflip () {
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
    echo '(╯°□°)╯︵┻━┻ '

    #replace dot gitness with clean representation
    cp -R ${TABLE_FLIP_DIR}/${BASE}/.git ${PWD}/

    # after success remove clean clone from temp
    rm -rf ${TABLE_FLIP_DIR}/${BASE}

    # echo happy strong emoji
}

alias git="git-or-flip"

