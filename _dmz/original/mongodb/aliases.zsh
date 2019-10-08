alias mongo-up='mongod --fork --logpath /usr/local/var/log/mongodb/mongo.log'
alias mongo-down='cat /usr/local/var/mongodb/mongod.lock | xargs kill -15'
