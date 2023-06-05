#!/bin/bash

if [ $# -ne 2 ]
then
        echo "StageForContainer.sh called with incorrect number of arguments."
        echo "StageForContainer.sh <unitPaht> <StageBaseDir>"
        echo "For example; StageForContainer.sh /plm/pnnas/ppic/users/<unit_name> /plm/pnnas/ppic/users/<stage_dir>"
        exit 1
fi

UNIT_PATH=$1
STAGE_BASE_DIR=$2

STAGE_DIR=${STAGE_BASE_DIR}/TranslatorBinaries/
SOURCE_PATH=${UNIT_PATH}

if [ ! -d ${STAGE_DIR} ]
then
	echo "Creating staging directory ${STAGE_DIR}"
	mkdir -p ${STAGE_DIR} || { exit 1;}
	chmod -R 0777 ${STAGE_DIR} || { exit 1;}
fi

# Copy all 
cp -r ${SOURCE_PATH}/*   ${STAGE_DIR}/ || { exit 1;}
echo " " >> ${STAGE_DIR}/dockerfile
echo " " >> ${STAGE_DIR}/dockerfile
echo "ENTRYPOINT /volume/step/run_stepdocker" >> ${STAGE_DIR}/dockerfile