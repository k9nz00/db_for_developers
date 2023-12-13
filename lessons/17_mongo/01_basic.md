Поиск документов

```javascript
db.users.find({"first_name": "Gemma"});
db.users.find({"karma": {$lt: 10}, "first_name": /.*an.*/});
skillbox > db.users.find({"last_name": {$exists: false}})
```

Ограничение количества результатов выборки

```javascript
db.users.find({"karma": {$lt: 10}, "first_name": /.*an.*/}).limit(1)
```

Обновить множество

```javascript
db.users.updateMany({"karma": {$lt: 10}, "first_name": /.*an.*/}, {$set: {"karma": 1}})
```

Вставить одну запись

```javascript
db.users.insertOne({"first_name": "test", "karma": 100, "admin": true})
```

Вставка множества записей

```javascript
db.users.insertMoney([
    {"first_name": "test1", "karma": 100, "admin": true},
    {"first_name": "test2", "karma": 100, "admin": true}
])
```
