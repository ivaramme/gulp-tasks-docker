#!/bin/bash

function init_gulp() {
       cp /conf/default-gulpfile.js gulpfile.js
}

npm install --save-dev gulp
npm install

if [ ! -e gulpfile.js ]; then
	echo "Creating default gulpfile.js"
	init_gulp
fi

echo "#########################################################################"
echo " Running GULP "
echo "#########################################################################"

gulp
