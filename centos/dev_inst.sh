#!/bin/bash
set -e
. ./env.sh

SERVICE=$1
SERVICE_FULL="miracl-$SERVICE"
VERSION=${2:+-$2}

TMPFILE=/tmp/$SERVICE_FULL-rpm

cat > $TMPFILE <<- EOM
[miracl]
name= Latest Release for RHEL/Centos 7Server
baseurl=http://repo.dev.miracl.net/yum/redhat/7Server
gpgkey=http://repo.dev.miracl.net/build-team-public.asc
enabled=1
gpgcheck=0
EOM

./cp.sh $TMPFILE /etc/yum.repos.d/miracl-rpm.repo
rm $TMPFILE

./inst.sh --enablerepo=miracl clean metadata
./inst.sh check-update -y || test $? == 100

./uninstall.sh $SERVICE
./inst.sh install -y -t $SERVICE_FULL$VERSION
