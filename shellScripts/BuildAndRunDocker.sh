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

#docker activities
docker build -t trx22:stepjt $STAGE_DIR -f $STAGE_DIR/dockerfile || { exit 1;}

docker run --name stepjt_testrun_container -v /apps/JenkinsBase/docker:/volume --cpus="1" --memory="2g" trx22:stepjt

#Now check for error in /volume/Logs/log.txt file
LOG_FILE=/apps/JenkinsBase/docker/step/Logs/step_log_pass.txt
errorCount=0

>/apps/JenkinsBase/docker/step/Logs/failedCases.txt

echo "Checking case for pass condition"

if [ -f $LOG_FILE ] 
then
	for failingCase in `grep -v ":0" /apps/JenkinsBase/docker/step/Logs/step_log_pass.txt`
	do
		echo $failingCase >>/apps/JenkinsBase/docker/step/Logs/failedCases.txt
		echo "Docker test run failed for part : $failingCase"
		((errorCount++))
	done
	
	if [ $errorCount -ne 0 ]
	then
		echo "Number of tests failed for Docker test = $errorCount. Exiting with error.Please find the failed test cases with error code at /apps/JenkinsBase/docker/step/Logs/failedCases.txt"
		exit 1
	fi
else
	echo "Could not find log file $LOG_FILE"
	exit 1
fi
