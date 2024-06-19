#!/bin/bash
# Use udclient to add files to a component version
# Prerequisites
#   - udclient authentication environment variables (DS_AUTH_TOKEN or DS_USERNAME/DS_PASSWORD) are set
#   - udclient weburl (DS_WEB_URL) is set
#   - JAVA_HOME environment variable is set

usage() {
    echo "usage: $0 cmdpath componentName componentVersion base offset include exclude saveExecuteBits"
    echo "cmdpath is the fully-qualified pathname for the udclient executable (required)"
    echo "componentName is the name/id of the component (required)"
    echo "componentVersion is the name/id of the component version (required)"
    echo "base if the local base directory for upload.  All files inside this will be sent. (required)"
    echo "offset is the target path (the directory in the version files to which these files should be added. (optional)"
    echo "include is an include file pattern for selecting files to add (may be repeated). (optional)"
    echo "exclude is an exclude file pattern for excluding files (may be repeated). (optional)"
    echo "saveExecuteBits specifies whether or not to save execute bits for files. (optional)"
    exit 1
}

if [ $# -lt 4 ]
then
    usage
fi

set -x

if [ -x "$1" ]
then
    CMD_PATH=$1
else
    echo "command path $1 is not an executable"
    usage
fi

$CMD_PATH addVersionFiles -component "$2" -version "$3" -base "$4"
