#!/bin/bash

set -e

export DATE="$(date -u '+%Y-%m-%d %H:%M:%S UTF')"
export LICENSE=MIT
export OS=$(uname -s)
export BRANCH=${BRANCH:-$(git branch |awk '/\*/ {print $2}')}
export REPO=$(git remote get-url origin)
export PROJECT=${REPO##*/}
export PROJECT=${PROJECT%.git}
export GITUSER=${REPO%/*}; GITUSER=${GITUSER##*[:/]}
export REVISION=$(git rev-parse HEAD)

echo "git branch: $(git branch)"
echo "git branch --contains: $(git branch --contains)"
echo "git rev-parse --abbrev-ref HEAD: $(git rev-parse --abbrev-ref HEAD)"
echo "OS=${OS}"
echo "BRANCH=${BRANCH}"
echo "REPO=${REPO}"
echo "PROJECT=${PROJECT}"
echo "GITUSER=${GITUSER}"
echo "REVISION=${REVISION}"
echo "DATE=${DATE}"

if [[ "$BRANCH" != "master" ]]; then
    exit 1;
fi

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


