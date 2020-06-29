#!/usr/bin/env bash -e

CONTAINER=$(docker build -q .)
CONTAINER=$(echo $CONTAINER | cut -d':' -f 2)

INSTANCE=$(docker run -d --rm $CONTAINER)

NAME=check_spot
VERSION=$(cat $NAME.spec |grep '^Version: ' | cut -d ' ' -f 2-)
RELEASE=$(cat $NAME.spec |grep '^Release: ' | cut -d ' ' -f 2-)

docker cp $INSTANCE:/root/rpmbuild/RPMS/x86_64/$NAME-$VERSION-$RELEASE.x86_64.rpm ./$NAME-$VERSION-$RELEASE.x86_64.rpm
docker kill $INSTANCE > /dev/null

[[ $SIGNING_KEY_NAME != "" ]] && rpm --addsign $NAME-$VERSION-$RELEASE.x86_64.rpm --define '%_gpg_name '"$SIGNING_KEY_NAME"

