#!/bin/bash

# Populate variables with default values

GLUON_GIT_REF=master 
GLUON_GIT=https://github.com/freifunk-gluon/gluon.git
GLUON_BUILD_DIR=gluon-build
GLUON_RELEASE=t0biii.2019.0-exp~dock06
OPENWRT_DIR=$(pwd)/openwrt
OUTPUT_DIR=$(pwd)/output
GLUON_BRANCH=experimental 
GLUON_TARGETS=x86-generic x86-geode x86-64


docker run --rm -a STDOUT -a STDERR -v $OPENWRT_DIR:/gluon/openwrt -v $OUTPUT_DIR:/gluon/output -w /gluon build-gluon /bin/bash -c "make GLUON_RELEASE=$GLUON_RELEASE GLUON_BRANCH=$GLUON_BRANCH GLUON_GIT_URL=$GLUON_GIT GLUON_GIT_REF=$GLUON_GIT_REF GLUON_TARGETS=$GLUON_TARGETS"
