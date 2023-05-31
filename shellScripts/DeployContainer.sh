#!/bin/bash

if [ $# -ne 3 ]
then
        echo "DeployContainer.sh called with incorrect number of arguments."
        echo "DeployContainer.sh <StageBaseDir> <DeployFlag> <unitPath>"
        echo "For example; DeployContainer.sh /plm/pnnas/ppic/users/<stage_dir> true/false /plm/pnnas/ppic/users/<unit_dir>"
        exit 1
fi

STAGE_BASE_DIR=$1
EXECUTE_DEPLOY=$2
UNIT_PATH=$3

STAGE_DIR=${STAGE_BASE_DIR}/TranslatorBinaries/

if [ ${EXECUTE_DEPLOY} == "true" ]
then
	INIT_DEF_FILE=${UNIT_PATH}/init.def
	stringarray=(`grep DMS_PARENT_BASELINE ${INIT_DEF_FILE} || { exit 1;}`)
	RELEASE_IP=${stringarray[1]}
	echo "Deploy flag is set to true. Executing deploy step with release IP = ${RELEASE_IP}..."
	
	orig=${RELEASE_IP}
	releaseName=${orig//'.'/'_TranslatorWorker.'}
	
	cd ${STAGE_BASE_DIR} || { exit 1;}
	tar -czf $releaseName.tar.gz TranslatorBinaries/ || { exit 1;}
	echo "curl -u opentools_bot:YL6MtwZ35 -T $releaseName.tar.gz https://artifacts.industrysoftware.automation.siemens.com/artifactory/generic-local/Opentools/PREVIEW/NXtoJT/$releaseName/ || { exit 1;}"

	echo "curl -u opentools_bot:YL6MtwZ35 -T NXJT_Translator_README.txt https://artifacts.industrysoftware.automation.siemens.com/artifactory/generic-local/Opentools/PREVIEW/NXtoJT/$releaseName/ || { exit 1;}"

	cd -
else
	echo "Deploy flag is set to false. Skipping deploy step..."
fi