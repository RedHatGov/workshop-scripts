#!/bin/bash

SCRIPTS_DIR=`dirname $0`

. $SCRIPTS_DIR/setup-environment.sh

echo "### Delete spawner resources."

if [ -d $WORKSHOP_DIR/resources/ ]; then
    oc delete -f $WORKSHOP_DIR/resources/ --recursive
fi

if [ -f $WORKSHOP_DIR/templates/spawner-resources.yaml ]; then
    oc process \
        -f $WORKSHOP_DIR/templates/spawner-resources.yaml \
        --param NAME_PREFIX="$NAME_PREFIX" \
        --param WORKSHOP_NAME="$WORKSHOP_NAME" \
        --param SPAWNER_NAMESPACE="$PROJECT_NAME" \
        --param SPAWNER_MODE="$SPAWNER_MODE" | \
        oc delete -f -
fi
