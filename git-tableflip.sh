#!/bin/bash
set -x
set -e

TABLE_FLIP_DIR="/tmp/git-table-flip"
BASE=$(basename $PWD)
DIR=$(dirname $PWD)
REMOTE=$(git config --get remote.origin.url)
TIMESTAMP=$(date +"%s")
mkdir -p ${TABLE_FLIP_DIR}

# if REMOTE empty exit 1

# make backup
cp -R "$PWD" "${TABLE_FLIP_DIR}/${BASE}_${TIMESTAMP}_backup"

# if multiple table flips this will error 
git clone "$REMOTE" "${TABLE_FLIP_DIR}/${BASE}"

# remove dot gitness
rm -rf "${PWD}/.git"

# echo tableflip emoji

cp -R ${TABLE_FLIP_DIR}/${BASE}/.git ${PWD}/

# after success remove clean clone from temp
rm -rf ${TABLE_FLIP_DIR}/${BASE}

# echo happy strong emoji

git status

