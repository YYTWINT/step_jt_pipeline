#!/bin/bash

if [ $# -ne 2 ] 
then
	echo "BuildAndRunDocker.sh called with incorrect number of arguments."
	echo "BuildAndRunDocker.sh <UnitPath> <StagePath> "
	echo "For example; BuildAndRunDocker.sh /plm/pnnas/ppic/users/<unit path> /plm/pnnas/ppic/users/<staging path>"
	exit 1
fi

UNIT_PATH=$1
STAGE_DIR=$2/TranslatorBinaries

docker build -t trx22:stepjt $STAGE_DIR -f $STAGE_DIR/dockerfile || { exit 1;}

docker run --name stepjt_testrun_container -v /apps/JenkinsBase/docker:/volume --cpus="1" --memory="2g" -itd trx22:stepjt

#Now check for error in /volume/Logs/log.txt file
LOG_FILE=/apps/JenkinsBase/docker/step/Logs/log_pass.txt
errorCount=0

echo "Checking case for pass condition"
if [ -f $LOG_FILE ] 
then
	for failingCase in $(cat /apps/JenkinsBase/docker/step/Logs/testing.txt | grep ":137" | cut -d : -f 1)
	do
		echo $failingCase >>/apps/JenkinsBase/docker/step/Logs/failedCases.txt
		echo "Docker test run failed for part : $failingCase"
		((errorCount++))
	done
	if [ $errorCount -ne 0 ]
	then
		echo "Number of tests failed for Docker test = $errorCount. Exiting with error."
		exit 1
	fi
else
	echo "Could not find log file $LOG_FILE"
	exit 1
fi
