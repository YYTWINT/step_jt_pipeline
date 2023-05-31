#!/bin/bash

# Check if license server docker container is up or not.
# If not then start the license server docker container.

if [ $( docker ps -a | grep saltd_container | wc -l ) -gt 0 ]; then
  echo "saltd_container exists"
  exit 0
else
  echo "saltd_container does not exist"
  exit 1
fi
