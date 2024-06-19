#!/bin/bash
# Use udclient to add files to a component version
# Prerequisites
#   - udclient authentication environment variables (DS_AUTH_TOKEN or DS_USERNAME/DS_PASSWORD) are set
#   - udclient weburl (DS_WEB_URL) is set
#   - JAVA_HOME environment variable is set

set -x
base_cmd=""

# Create the command to execute
if [ -z $FILES_CMD ]
then
  echo "udclient command not specified.  Exiting"
  exit 1
else
  base_cmd="\"$FILES_CMD\" addVersionFiles"
fi

# Specify component name
if [ -z $FILES_COMPONENTNAME ]
then
  echo "Component name not specified.  Exiting"
  exit 1
else
  base_cmd+=" -component \"$FILES_COMPONENTNAME\""
fi

# Specify component version name
if [ -z "$FILES_VERSIONNAME" ]
then
  echo "Version name not specified.  Exiting"
  exit 1
else
  base_cmd+=" -version \"$FILES_VERSIONNAME\""
fi

# Specify local path
if [ -z $FILES_BASE ]
then
  echo "No base files specified. Exiting"
  exit 1
else
  base_cmd+=" -base \"$FILES_BASE\""
fi

if [ ! -z "$FILES_OFFSET" ]
then
  base_cmd+=" -offset \"$FILES_OFFSET\""
fi

if [ ! -z $FILES_INCLUDE ]
then
  base_cmd+=" -include \"$FILES_INCLUDE\""
fi

if [ ! -z $FILES_EXCLUDE ]
then
  base_cmd+=" -exclude \"$FILES_EXCLUDE\""
fi

if [ ! -z $FILES_SAVEEXECUTEBITS ]
then
  base_cmd+=" -saveExecuteBits \"$FILES_SAVEEXECUTEBITS\""
fi

echo $base_cmd

# Invoke the udclient to add version files to the component version
eval $base_cmd
