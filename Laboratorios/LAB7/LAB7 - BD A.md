# LABORATORIO 7 - MONGO DB - Base de Datos A

Xabier Gabiña - 35.195.82.3

## Tarea 1

### Tarea 1.1

```
bash> wget https://raw.githubusercontent.com/mcampo2/mongodb-sample-databases/master/sample_analytics/accounts.json

bash> wget https://raw.githubusercontent.com/mcampo2/mongodb-sample-databases/master/sample_analytics/customers.json

bash> wget https://raw.githubusercontent.com/mcampo2/mongodb-sample-databases/master/sample_analytics/transactions.json
```

### Tarea 1.2

```
bash> mongoimport accounts.json -d Analytics -c accounts

bash> mongoimport customers.json -d Analytics -c customers

bash> mongoimport transactions.json -d Analytics -c transactions
```
## Tarea 2

### Tarea 2.1

#### Tarea 2.1.1

```
bash> mongosh
mongosh> use admin
mongosh> db.createUser({
    user:"Xabier"
    pwd:"xabier2001"
    roles:["root"]
})
```

#### Tarea 2.1.2

```
bash> sudo nano /etc/mongod.conf
nano>
security:
  authorization: enabled
bash> sudo systemctl restart mongod.service
```

###
 Tarea 2.2

```
bash> mongosh -u Xabier -p xabier2001
mongosh> use Analytics
mongosh> db.createUser({
    user:"Fran",
    pwd:"fran2001",
    roles:[
        {role: "readWrite", db: "Analytics"},
    ]
})
```

## Tarea 3

```
bash> mongodump -u Xabier -p xabier2001 --authenticationDatabase admin -d Analytics
```

## Tarea 4

```
bash> ssh 35.233.35.75

bash> mongosh

mongosh>use Mflx

mongosh>db.auth("Xabier", "xabier2001")

mongosh>db.movies.find({ fullplot: /red/ })

```

## Tarea 5

```
mongosh> db.movies.explain("executionStats").find({ fullplot : /red/ })
executionStats: {
    executionSuccess: true,
    nReturned: 4907,
    executionTimeMillis: 66,
    totalKeysExamined: 0,
    totalDocsExamined: 23539,
    executionStages: {
      stage: 'COLLSCAN',
      filter: { fullplot: { '$regex': 'red' } },
      nReturned: 4907,
      executionTimeMillisEstimate: 10,
      works: 23541,
      advanced: 4907,
      needTime: 18633,
      needYield: 0,
      saveState: 23,
      restoreState: 23,
      isEOF: 1,
      direction: 'forward',
      docsExamined: 23539
    }
  }

mongosh> db.movies.createIndex({fullplot:"text"})

mongosh> db.movies.explain("executionStats").find({ fullplot : /red/ })
 executionStats: {
    executionSuccess: true,
    nReturned: 4907,
    executionTimeMillis: 111,
    totalKeysExamined: 0,
    totalDocsExamined: 23539,
    executionStages: {
      stage: 'COLLSCAN',
      filter: { fullplot: { '$regex': 'red' } },
      nReturned: 4907,
      executionTimeMillisEstimate: 41,
      works: 23541,
      advanced: 4907,
      needTime: 18633,
      needYield: 0,
      saveState: 23,
      restoreState: 23,
      isEOF: 1,
      direction: 'forward',
      docsExamined: 23539
    }
  }
```

## Tarea 6

```
mongosh> db.movies.drop()
```

## Tarea 7

```
bash> mongorestore -u Xabier -p xabier2001 --authenticationDatabase admin -d Analytics
```
