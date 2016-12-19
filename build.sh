#!/bin/sh
coffee -c grimper-chez-les-voisins.coffee && uglifyjs grimper-chez-les-voisins.js --screw-ie8 -m -o dev.js
