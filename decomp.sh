#!/bin/sh

if [ -f trees.diff ]; then
    echo "Deleting old tree diff"
    rm trees.diff
fi

if [ -f changes.diff ]; then
    echo "Deleting diff of previous changes"
    rm changes.diff
fi

if [ -d tree/old ]; then
    echo "Rotating backups"
    if [ -d tree/old2 ]; then
        rm -rf tree/old2
        if [ -d tree/old2_raw ]; then
            rm -rf tree/old2_raw
        fi
    fi
    mv tree/old tree/old2
    if [ -d tree/old_raw ]; then
        mv tree/old_raw tree/old2_raw
    fi
fi

if [ -d tree/current ]; then
    echo "Backing up current trees"
    mv tree/current tree/old
    mv tree/current_raw tree/old_raw
fi 

echo "Decompiling current apk"
dapktool d base/current.apk -b -o tree/current_raw

echo "Creating working copy"
cp -r tree/current_raw tree/current

if [ -d tree/old ]; then
    echo "Diffing to old tree"
    diff -r tree/old_raw tree/current_raw>trees.diff
fi

if [ -d tree/old ]; then
echo "Diffing out all changes made to the old tree"
    diff -r tree/old_raw tree/old>changes.diff
fi