#!/bin/bash
# Use udclient to add properties to a component version
# Prerequisites
#   - udclient authentication environment variables (DS_AUTH_TOKEN or DS_USERNAME/DS_PASSWORD) are set
#   - udclient weburl (DS_WEB_URL) is set
#   - JAVA_HOME environment variable is set

#set -x
base_cmd=""

# Create the command to execute
if [ -z $VERSION_PROPERTIES_CMD ]
then
  echo "udclient command not specified.  Exiting"
  exit 1
else
  base_cmd="\"$VERSION_PROPERTIES_CMD\" setVersionProperty"
fi

# Specify component name
if [ -z $VERSION_PROPERTIES_COMPONENTNAME ]
then
  echo "Component name not specified.  Exiting"
  exit 1
else
  base_cmd+=" -component \"$VERSION_PROPERTIES_COMPONENTNAME\""
fi

# Specify component version name
if [ -z "$VERSION_PROPERTIES_VERSIONNAME" ]
then
  echo "Version name not specified.  Exiting"
  exit 1
else
  base_cmd+=" -version \"$VERSION_PROPERTIES_VERSIONNAME\""
fi

# Check to make sure that at least 1 version property was specified
if [ -z "$VERSION_PROPERTIES" ]
then
  echo "version properties not specified.  Exiting"
  exit 1
fi

# Loop through new-line delineated component version properties and invoke CLI for each property definition
while IFS=":" read key value secure remainder
do
    property_cmd="$base_cmd -name \"$key\" -value \"$value\" -secure $secure"
    echo $property_cmd
    eval $property_cmd
    unset property_cmd
done <<< $VERSION_PROPERTIES

