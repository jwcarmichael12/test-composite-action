#!/bin/bash
# Use udclient to add files to a component version
# Prerequisites
#   - udclient authentication environment variables (DS_AUTH_TOKEN or DS_USERNAME/DS_PASSWORD) are set
#   - udclient weburl (DS_WEB_URL) is set
#   - JAVA_HOME environment variable is set

# Create the command to execute
if [ -z FILES_CMD ]
  echo "udclient command not specified.  Exiting"
  exit 1
else
  BASE_CMD="\"$CMD_PATH\" addVersionFiles"

# Specify component name
if [ -z $FILES_COMPONENTNAME ]
  echo "Component name not specified.  Exiting"
  exit 1
else
  BASE_CMD = "$BASE_CMD -component \"$FILES_COMPONENTNAME\""

# Specify component version name
if [ -z $FILES_VERSIONNAME ]
  echo "Version name not specified.  Exiting"
  exit 1
else
  BASE_CMD = "$BASE_CMD -version \"$FILES_VERSIONNAME\""

if [ -z $FILES_BASE ]
  echo "No base files specified. Exiting"
  exit 1
else
  BASE_CMD = "$BASE_CMD -base \"$FILES_BASE\""
fi

# Invoke the udclient to add version files to the component version
eval $BASE_CMD
