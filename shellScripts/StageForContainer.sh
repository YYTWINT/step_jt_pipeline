#!/bin/bash

if [ $# -ne 3 ]
then
        echo "StageForContainer.sh called with incorrect number of arguments."
        echo "StageForContainer.sh <unitPaht> <StageBaseDir> <CustomerArtifactDir>"
        echo "For example; StageForContainer.sh /plm/pnnas/ppic/users/<unit_name> /plm/pnnas/ppic/users/<stage_dir> <Artifacts>"
        exit 1
fi

UNIT_PATH=$1
STAGE_BASE_DIR=$2
CUSTOMER_ARTIFACTS_DIR=$3

STAGE_DIR=${STAGE_BASE_DIR}/TranslatorBinaries/
SOURCE_PATH=${UNIT_PATH}/lnx64/Products/TranslatorWorker

if [ ! -d ${STAGE_DIR} ]
then
	echo "Creating staging directory ${STAGE_DIR}"
	mkdir -p ${STAGE_DIR} || { exit 1;}
	chmod -R 0777 ${STAGE_DIR} || { exit 1;}
fi

# Copy all 
cp -r ${SOURCE_PATH}/*   ${STAGE_DIR}/ || { exit 1;}

# Then remove selected iteams
rm -rf ${STAGE_DIR}/debug || { exit 1;}
rm -rf ${STAGE_DIR}/license || { exit 1;}

CONFIG_FILE_MULTICAD=${STAGE_DIR}/tessUG_multicad.config
CONFIG_FILE_VIS=${STAGE_DIR}/tessUG_vis.config
RUN_UGTOPV_MULTICAD=${STAGE_DIR}/run_ugtopv_multicad
RUN_UGTOPV_VIS=${STAGE_DIR}/run_ugtopv_vis

cp -f ${CUSTOMER_ARTIFACTS_DIR}/run_ugtopv_multicad ${RUN_UGTOPV_MULTICAD} || { exit 1;}
cp -f ${CUSTOMER_ARTIFACTS_DIR}/run_ugtopv_vis ${RUN_UGTOPV_VIS} || { exit 1;}
cp -f ${CUSTOMER_ARTIFACTS_DIR}/tessUG_multicad.config ${CONFIG_FILE_MULTICAD} || { exit 1;}
cp -f ${CUSTOMER_ARTIFACTS_DIR}/tessUG_vis.config ${CONFIG_FILE_VIS} || { exit 1;}
cp -f ${CUSTOMER_ARTIFACTS_DIR}/NXJT_Translator_README.txt ${STAGE_BASE_DIR}/ || { exit 1;}

chmod 0755 ${CONFIG_FILE_MULTICAD} || { exit 1;}
chmod 0755 ${CONFIG_FILE_VIS} || { exit 1;}
chmod 0755 ${RUN_UGTOPV_MULTICAD} || { exit 1;}
chmod 0755 ${RUN_UGTOPV_VIS} || { exit 1;}

# IP 10.146.116.128 is a flex licenser server IP
# echo "ENV SPLM_LICENSE_SERVER=29000@10.146.116.128" >> ${STAGE_DIR}/dockerfile 

# IP 172.17.0.2 is a saltd container IP
echo "ENV SPLM_LICENSE_SERVER=29000@172.17.0.2" >> ${STAGE_DIR}/dockerfile
echo " " >> ${STAGE_DIR}/dockerfile

echo "COPY run_ugtopv_vis         /app/run_ugtopv_vis" >> ${STAGE_DIR}/dockerfile
echo "COPY tessUG_vis.config      /app/tessUG_vis.config" >> ${STAGE_DIR}/dockerfile
echo "COPY run_ugtopv_multicad         /app/run_ugtopv_multicad" >> ${STAGE_DIR}/dockerfile
echo "COPY tessUG_multicad.config      /app/tessUG_multicad.config" >> ${STAGE_DIR}/dockerfile
echo " " >> ${STAGE_DIR}/dockerfile
echo " " >> ${STAGE_DIR}/dockerfile
echo " " >> ${STAGE_DIR}/dockerfile
echo "ENTRYPOINT /volume/run_docker" >> ${STAGE_DIR}/dockerfile
