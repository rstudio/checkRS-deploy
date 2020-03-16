#!/bin/bash
DESC=($(git describe --match 'v*' 2>/dev/null | sed "s/v\([0-9\.]*\)-*\([0-9]*\)-*\([0-9a-z]*\)/\1 \2 \3/")) 

VERSION=($(echo ${DESC[0]} | tr "." " "))
VERSION_MAJ=${VERSION[0]}
VERSION_MIN=${VERSION[1]}
VERSION_REV=${VERSION[2]}

# get the number of commits since the last tag
COMMITS=${DESC[1]}
if [ -z "${COMMITS}" ]; then
    COMMITS="0"
fi;

# use BUILD_NUMBER if supplied
if [ "${BUILD_NUMBER}" ]; then
    BUILD="${BUILD_NUMBER}"
else
    BUILD="dev${COMMITS}"
fi

while getopts "mnrb" opt; do
    case $opt in
        m)
            # Major Version 
            echo "${VERSION_MAJ}"
            exit 0
            ;;
        n)
            # Minor Version
            echo "${VERSION_MIN}"
            exit 0
            ;;
        r)
            # Revision Version 
            echo "${VERSION_REV}"
            exit 0
            ;;
        b)
            # Build
            echo "${BUILD}"
            exit 0
            ;;
        \?)
            echo "Invalid option: -$OPTARG" >&2
            exit 1
            ;;
    esac
done

VERSION="${VERSION_MAJ}.${VERSION_MIN}"

if [ "${VERSION_REV}" ]; then
    VERSION="${VERSION}.${VERSION_REV}"
fi

if [ "${BUILD}" ]; then
    VERSION="${VERSION}.${BUILD}"
fi

echo ${VERSION}
