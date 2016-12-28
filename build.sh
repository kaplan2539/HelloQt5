#!/bin/bash

set -e

OS=$(uname -s)

build() {
rm -rf build
mkdir build
pushd build
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
