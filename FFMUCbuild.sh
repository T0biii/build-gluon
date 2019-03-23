#!/bin/bash

# Populate variables with default values

BROKEN=0 # -b
DIRCLEAN=1 # -d

#GLUON_TARGET= # -t
#GLUON_VERSION= # -v
#SITE_BRANCH=master # -z
#SITE_GIT= # -s
#JOBS=$(grep -c processor /proc/cpuinfo) # -j

GLUON_GIT_REF=master # -g
GLUON_GIT=https://github.com/freifunk-gluon/gluon.git
GLUON_BUILD_DIR=gluon-build
GLUON_RELEASE= # -r
OPENWRT_DIR=$(pwd)/openwrt # -l
OUTPUT_DIR=$(pwd)/output # -o
GLUON_BRANCH=experimental 
GLUON_TARGETS=x86-generic x86-geode x86-64

# Process flags

while getopts ":bdg:j:l:o:r:s:t:v:z:" opt; do
  case $opt in
    b)
      BROKEN=1
      ;;
    d)
      DIRCLEAN=1
      ;;
    g)
      GLUON_BRANCH="$OPTARG"
      ;;
    j)
      JOBS="$OPTARG"
      ;;
    l)
      LEDE_DIR="$OPTARG"
      ;;
    o)
      OUTPUT_DIR="$OPTARG"
      ;;
    r)
      GLUON_RELEASE="$OPTARG"
      ;;
    s)
      SITE_GIT="$OPTARG"
      ;;
    t)
      GLUON_TARGET="$OPTARG"
      ;;
    v)
      GLUON_VERSION="$OPTARG"
      ;;
    z)
      SITE_BRANCH="$OPTARG"
      ;;
   \?)
      echo "Invalid option: -$OPTARG" >&2
      exit 1
      ;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1
      ;;
  esac
done

docker run --rm -a STDOUT -a STDERR -v $OPENWRT_DIR:/gluon/openwrt -v $OUTPUT_DIR:/gluon/output -w /gluon build-gluon /bin/bash -c "make GLUON_RELEASE=$GLUON_RELEASE GLUON_BRANCH=$GLUON_BRANCH GLUON_GIT_URL=$GLUON_GIT GLUON_GIT_REF=$GLUON_GIT_REF GLUON_TARGETS=$GLUON_TARGETS"
