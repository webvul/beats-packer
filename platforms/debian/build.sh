#!/bin/sh

set -e

# executed from the top directory
runid=debian-$BEAT-$RELEASE-$ARCH
cat beats/$BEAT.yml archs/$ARCH.yml releases/$RELEASE.yml > build/settings-$runid.yml
gotpl platforms/debian/run.sh.j2 < build/settings-$runid.yml > build/run-$runid.sh
gotpl platforms/debian/init.j2 < build/settings-$runid.yml > build/$runid.init
chmod +x build/run-$runid.sh
docker run -v `pwd`/build:/build -e BUILDID=$BUILDID -e RUNID=$runid tudorg/fpm /build/run-$runid.sh
rm build/settings-$runid.yml build/run-$runid.sh
