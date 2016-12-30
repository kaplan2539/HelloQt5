#!/bin/bash

for b in develop release master; do
    for p in ubuntu mac win; do
        for n in `seq 1 10`; do
            echo -e "\
type: build\n\
branch: $b\n\
number: $n\n\
platform: $p\n\
revision: $(echo $RANDOM | md5sum | awk '{print $1}')\n\
artifact: HelloQt.$p\n\
artifact_md5: $(echo $RANDOM | md5sum | awk '{print $1}')\n\
artifact_url: http://dl.bintray/kaplan2539/HelloQt5/$b/$p/HelloQt.$p\n\
" >build_${b}_${p}_${n}.yml
        done
    done
done
