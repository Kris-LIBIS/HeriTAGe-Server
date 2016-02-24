#!/bin/bash
cd `dirname $0`
mkdir -p ./data/db
DATA="$PWD/data"
mongod --shutdown --config "$PWD/mongod.conf" --logpath "$DATA/mongod.log" --pidfilepath "$DATA/mongod.pid" --dbpath "$DATA/db"

