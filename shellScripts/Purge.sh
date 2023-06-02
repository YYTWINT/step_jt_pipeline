#/bin/bash

# This purge script keeps latest 3 directories in the location passed as an argument to it.
if [ $# -ne 1 ]
then
        echo "Purge.sh called with incorrect number of arguments."
        echo "Purge.sh <location>"
        echo "For example; Purge.sh /plm/pnnas/ppic/users/<unit_dir>"
        exit 1
fi

WORK_DIR=$1
KEEP_DIR_COUNT=

echo "Purging dir ${WORK_DIR}"

cd ${WORK_DIR} || { exit 1;}

dirNames=(`ls -tp | grep  '/$'`)
numDirs=${#dirNames[@]}
echo "Found ${numDirs} directories..."

if [ ${numDirs} -gt ${KEEP_DIR_COUNT} ]
then
        for ((number=KEEP_DIR_COUNT;number<numDirs;number++))
        do
			echo "Deleting ${dirNames[${number}]}"
			rm -rf ${dirNames[${number}]}
        done
fi

cd -
