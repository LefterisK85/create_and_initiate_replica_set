#!/usr/bin/env bash

# Create three directories where the data of each mongod server will be saved
mkdir -p /data/rs1 /data/rs2 /data/rs3

# Start three mongod instances
mongod --replSet mytest --logpath "1.log" --dbpath /data/rs1 --port 27017
mongod --replSet mytest --logpath "2.log" --dbpath /data/rs2 --port 27018
mongod --replSet mytest --logpath "3.log" --dbpath /data/rs3 --port 27019

# mongod --replSet mytest --> declare each one is part of the same replica set named mytest
# --logpath "1.log"       --> put its log in a log file called 1.log
# --dbpath /data/rs1      --> the path where it's going to put its data files
# --port 27017            --> the port where it's going to listen on

# Some time for the replica set to come up
sleep 5

# Connect to one server and initiate the set
echo "Configuring replica set"
mongo --port 27017 << 'EOF'
config = { _id: "mytest", members:[ { _id : 0, host : "localhost:27017"},
                                    { _id : 1, host : "localhost:27018"},
         				            { _id : 2, host : "localhost:27019"}  ]   };
rs.initiate(config);
EOF

# EOF --> Take input from the following file 
# The content of the file is redirected to standard input of the preceding command




















