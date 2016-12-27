#!/bin/bash

brew_install() 
{
    PACKAGE=$1
    if [[ -z "$PACKAGE" ]]; then
        return 1;
    fi

    brew ls --versions $PACKAGE > /dev/null || brew install $PACKAGE
}

brew_install cmake
brew_install qtbase5-dev
brew_install librsvg
brew_install ninja
