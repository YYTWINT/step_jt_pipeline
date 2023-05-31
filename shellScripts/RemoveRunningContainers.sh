#!/bin/bash

# This script deletes all running continers except license server container "saltd_container"

for containerId in `docker ps -a | grep "nxjt_testrun_container" | awk  '{print $1}'`
do
	echo "Removing container with ID $containerId"
	docker rm -v -f $containerId
done

docker rmi -f $(docker images -f dangling=true -q)

docker image prune -a --force

exit 0