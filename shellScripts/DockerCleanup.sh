#!/bin/bash

if [ $# -ne 1 ] 
then
	echo "DockerCleanup.sh called with incorrect number of arguments."
	echo "DockerCleanup.sh <StagePath> "
	echo "For example; DockerCleanup.sh /plm/pnnas/ppic/users/<staging path>"
	exit 1
fi

STAGE_DIR=$1

rm -rf ${STAGE_DIR}/TranslatorBinaries/dockerfile || { exit 1;}
