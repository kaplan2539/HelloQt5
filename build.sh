#!/bin/bash

set -e

export OS=$(uname -s)
export BRANCH=$(git branch |awk '/\*/ {print $2}')
export REPO=$(git remote get-url origin)
export PROJECT=${REPO##*/}
export GITUSER=${REPO%/*}; GITUSER=${GITUSER##*[:/]}

echo "OS=${OS}"
echo "BRANCH=${BRANCH}"
echo "REPO=${REPO}"
echo "PROJECT=${PROJECT}"
echo "GITUSER=${GITUSER}"

build() {
rm -rf build
mkdir build
pushd build
envsubst <../bintray.json.in >bintray.json
cmake -G Ninja ..
ninja
cpack
popd
}

case "${OS}" in

    Darwin)
    mac/setup.sh
    ;;

    Linux)
    ubuntu/setup.sh
    ;;

    *)
    echo "SORRY: building on OS \"${OS}\" not implemented yet"
    exit 1
    ;;
esac

build


