Примеры аггрегационных запросов в mongo

```javascript
db.users
.aggregate([
{$match: {"_id": /example.info/}},
{$project: {karma: "$karma", year: {$year: "$birth_date"}}},
{$group: {_id: "$year", avg_karma: {$avg: "$karma"}}}
]);
```

```javascript
db.posts
.aggregate(
{$unwind: "$topics"},
{$project: {topic: "$topics"}},
{$group: {_id: "$topic", cnt: {$sum: 1}}},
{$sort: {cnt: -1}},
{$limit: 10}
);
```

Наблюдалась проблема, что запрос с переносами строк не работал корректно. 
Пока как решение перенес все в одну строку. Далее пример запроса, отформатированный в одну строку

```javascript
db.posts.aggregate({$unwind: "$topics"}, {$project: {"topic": "$topics"}}, {$group: {_id: "$topic", cnt: {$sum: 1}}})
```
