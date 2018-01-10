library(devtools)
install_github(repo = "mongosoup/rmongodb")
library(rmongodb)

#zuerst mongod in console und dann noch mongo starten um datenbank zu laden
mongo = mongo.create(host = "localhost")
mongo.is.connected(mongo)

mongo.get.databases(mongo)

mongo.get.database.collections(mongo, db = "test")

