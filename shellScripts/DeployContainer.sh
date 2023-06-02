#!/bin/bash

if [ $# -ne 4 ]
then
        echo "DeployContainer.sh called with incorrect number of arguments."
        echo "DeployContainer.sh <StageBaseDir> <DeployFlag> <unitPath> <productVersion>"
        echo "For example; DeployContainer.sh /plm/pnnas/ppic/users/<stage_dir> true/false /plm/pnnas/ppic/users/<unit_dir> <productVersion>"
        exit 1
fi

STAGE_BASE_DIR=$1
EXECUTE_DEPLOY=$2
UNIT_PATH=$3
PRODUCTVERSION=$4

STAGE_DIR=${STAGE_BASE_DIR}/TranslatorBinaries/

if [ ${EXECUTE_DEPLOY} == "true" ]
then
	echo "Deploy flag is set to true. Executing deploy stage for step to jt ${PRODUCTVERSION}..."
	
	releaseName='STEP_'${PRODUCTVERSION}
	
	cd ${STAGE_BASE_DIR} || { exit 1;}
	tar -czf $releaseName.tar.gz TranslatorBinaries/ || { exit 1;}
	
	echo "curl -u opentools_bot:YL6MtwZ35 -T $releaseName.tar.gz https://artifacts.industrysoftware.automation.siemens.com/artifactory/generic-local/Opentools/PREVIEW/NXtoJT/$releaseName/ || { exit 1;}"
	
	echo "curl -u opentools_bot:YL6MtwZ35 -T $releaseName.tar.gz https://artifacts.industrysoftware.automation.siemens.com/artifactory/generic-local/Opentools/PREVIEW/NXtoJT/$releaseName/">deployStep.txt

	echo "curl -u opentools_bot:YL6MtwZ35 -T JT_Translator_for_STEP_V4_0_0_SaaS_README.txt https://artifacts.industrysoftware.automation.siemens.com/artifactory/generic-local/Opentools/PREVIEW/NXtoJT/$releaseName/ || { exit 1;}"

	echo "curl -u opentools_bot:YL6MtwZ35 -T JT_Translator_for_STEP_V4_0_0_SaaS_README.txt https://artifacts.industrysoftware.automation.siemens.com/artifactory/generic-local/Opentools/PREVIEW/NXtoJT/$releaseName/">>deployStep.txt
	
	cp $releaseName.tar.gz deployStep.txt ${UNIT_PATH}

	cd -
else
	echo "Deploy flag is set to false. Skipping deploy step..."
fi