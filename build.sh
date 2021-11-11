#!/bin/sh

if [ ! -f src.ain ]; then
    cp ../Rance10.ain ./src.ain || exit 1
fi

alice project build "Rance10.pje"
