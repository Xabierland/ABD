# LABORATORIO 7 - MONGO DB - Base de Datos B

Francisco Gonzalez - 35.233.35.75

# Tarea 1

## Tarea 1.1

```
bash> wget https://raw.githubusercontent.com/mcampo2/mongodb-sample-databases/master/sample_mflix/comments.json

bash> wget https://raw.githubusercontent.com/mcampo2/mongodb-sample-databases/master/sample_mflix/movies.json

bash> wget https://raw.githubusercontent.com/mcampo2/mongodb-sample-databases/master/sample_mflix/sessions.json

bash> wget https://raw.githubusercontent.com/mcampo2/mongodb-sample-databases/master/sample_mflix/theaters.json

bash> wget https://raw.githubusercontent.com/mcampo2/mongodb-sample-databases/master/sample_mflix/users.json
```

## Tarea 1.2

```
bash> mongoimport comments.json -d Mflx -c comments

bash> mongoimport movies.json -d Mflx -c movies

bash> mongoimport sessions.json -d Mflx -c sessions

bash> mongoimport theaters.json -d Mflx -c theaters

bash> mongoimport users.json -d Mflx -c users
```

# Tarea 2

## Tarea 2.1

### Tarea 2.1.1

```
bash> mongosh

mongosh> use admin

mongosh> db.createUser({
    user:"Fran",
    pwd:"fran2001",
    roles:["root"]
})
```

### Tarea 2.1.2

```
bash> sudo nano /etc/mongod.conf

nano>
security:
  authorization: enabled

bash> sudo systemctl restart mongod.service
```

## Tarea 2.2

```
bash> mongosh -u Fran -p fran2001

mongosh> use Mflx

mongosh> db.createUser({
    user:"Xabier",
    pwd:"xabier2001",
    roles:[
        {role: "readWrite", db: "Mflx"}
    ]
})
```

# Tarea 3

```
bash> mongodump -u Fran -p fran2001 --authenticationDatabase admin -d Mflx
```

# Tarea 4

```
bash> ssh 35.195.82.3

bash> mongosh

mongosh>use Analytics

mongosh>db.auth("Fran", "fran2001")

mongosh>
db.customers.aggregate([
  {
    $unwind: "$accounts"
  },
  {
    $lookup: {
      from: "transactions",
      localField: "accounts",
      foreignField: "account_id",
      as: "joinCT"
    }
  },
  {
    $unwind: "$joinCT"
  },
  {
    $unwind: "$joinCT.transactions"
  },
  {
    $group: {
      _id: "$_id",
      totalAmount: { $sum: "$joinCT.transactions.amount" },
      username: { $first: "$username" },
      account: { $first: "$accounts" }
    }
  },
  {
    $project: {
      _id: 0,
      username: 1,
      account: 1,
      totalAmount: 1
    }
  }
])

```

# Tarea 5

```
mongosh> db.customers.explain("executionStats").aggregate([{$unwind: "$accounts"},{$lookup: {from: "transactions",localField: "accounts",foreignField: "account_id",as: "joinCT"}},{$unwind: "$joinCT"},{$unwind: "$joinCT.transactions"},{$group: {_id: "$_id",totalAmount: { $sum: "$joinCT.transactions.amount" },username: { $first: "$username" },account: { $first: "$accounts" }}},{$project: {_id: 0,username: 1,account: 1,totalAmount: 1}}])
executionStats: {
  executionSuccess: true,
  nReturned: 500,
  executionTimeMillis: 2108,
  totalKeysExamined: 0,
  totalDocsExamined: 500,
  executionStages: {
    stage: 'PROJECTION_DEFAULT',
    nReturned: 500,
    executionTimeMillisEstimate: 0,
    works: 502,
    advanced: 500,
    needTime: 1,
    needYield: 0,
    saveState: 1,
    restoreState: 1,
    isEOF: 1,
    transformBy: {
      _id: 1,
      accounts: 1,
      'joinCT.transactions': 1,
      username: 1
    },
    inputStage: {
      stage: 'COLLSCAN',
      nReturned: 500,
      executionTimeMillisEstimate: 0,
      works: 502,
      advanced: 500,
      needTime: 1,
      needYield: 0,
      saveState: 1,
      restoreState: 1,
      isEOF: 1,
      direction: 'forward',
      docsExamined: 500
    }
  }
}

mongosh> db.customers.createIndex({accounts: 1})

mongosh> db.transactions.createIndex({account_id: 1})

mongosh> db.customers.explain("executionStats").aggregate([{$unwind: "$accounts"},{$lookup: {from: "transactions",localField: "accounts",foreignField: "account_id",as: "joinCT"}},{$unwind: "$joinCT"},{$unwind: "$joinCT.transactions"},{$group: {_id: "$_id",totalAmount: { $sum: "$joinCT.transactions.amount" },username: { $first: "$username" },account: { $first: "$accounts" }}},{$project: {_id: 0,username: 1,account: 1,totalAmount: 1}}])
executionStats: {
  executionSuccess: true,
  nReturned: 500,
  executionTimeMillis: 236,
  totalKeysExamined: 0,
  totalDocsExamined: 500,
  executionStages: {
    stage: 'PROJECTION_DEFAULT',
    nReturned: 500,
    executionTimeMillisEstimate: 0,
    works: 502,
    advanced: 500,
    needTime: 1,
    needYield: 0,
    saveState: 1,
    restoreState: 1,
    isEOF: 1,
    transformBy: {
      _id: 1,
      accounts: 1,
      'joinCT.transactions': 1,
      username: 1
    },
    inputStage: {
      stage: 'COLLSCAN',
      nReturned: 500,
      executionTimeMillisEstimate: 0,
      works: 502,
      advanced: 500,
      needTime: 1,
      needYield: 0,
      saveState: 1,
      restoreState: 1,
      isEOF: 1,
      direction: 'forward',
      docsExamined: 500
    }
  }
}
```

# Tarea 6

```
mongosh> db.accounts.drop()
```

# Tarea 7

```
bash> mongorestore -u Fran -p fran2001 --authenticationDatabase admin -d Mflx
```
