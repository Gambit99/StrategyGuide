#!/bin/bash

XSLTPROC=xsltproc
techahome=~/dev/techa
rootdir=`pwd`

pushd src;
src_list=`find -name '*.xml'`;
popd;
xsl_list=`find ./xsl -name 'target-*.xsl'`;

if [ ! -d buildroot/unitpics ]; then
    echo "*** Migrating unit pictures to buildroot/unitpics"
    mkdir -p buildroot/unitpics
    pushd $techahome
    rsync -arv unitpics $rootdir/buildroot/
    popd
fi

if [ ! -L buildroot/img ]; then
    pushd buildroot
    rm -rf img
    ln -s ../img
    popd
fi


for xsl in $xsl_list; do
    tgtname=$(basename $xsl .xsl)
    tgtname=${tgtname:7}
    tgtroot=buildroot/$tgtname
    rm -rf $tgtroot
    
    echo "*** Building $tgtname in $tgtroot"
    for fn in $src_list; do
	sfn=${fn:2}
	ofn=${sfn/.xml/.html}
	outdir=$(dirname $ofn)
	mkdir -p $tgtroot/$outdir
	$XSLTPROC $xsl src/$sfn > $tgtroot/$ofn
    done
    
done

