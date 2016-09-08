#!/bin/bash

function init_gulp() {
       cp /conf/default-gulpfile.js gulpfile.js
}

GULP_INSTALLED=`npm list gulp`
echo $GULP_INSTALLED
if [[ "$GULP_INSTALLED" == *"empty"* ]]; then
	echo "Installing local gulp"
	npm install --save-dev gulp
fi

if [ -e package.json ]; then
	echo "Installing package.json"
	npm install
fi

if [ ! -e gulpfile.js ]; then
	echo "Creating default gulpfile.js"
	init_gulp
fi

echo "#########################################################################"
echo " Running GULP "
echo "#########################################################################"

gulp "$@"
