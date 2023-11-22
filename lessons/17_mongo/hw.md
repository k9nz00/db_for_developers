### Задание 1

Из коллекции постов выберите документы, в которых среди топиков встречается as,
идентификатор автора содержит example.ru, а score больше 100.

Ответ:

```javascript
db.posts.find({topics: /.*as.*/, score: {$gt: 100}, author: {$regex: "example.ru"}});
```

### Задание 2

Одним запросом добавьте два документа к коллекции posts:
creation_date — текущее время, автор — skbx@example.com, topics должен быть списком из одного элемента mongodb;
creation_date — 31 декабря 2021 года, автор — skbx@example.ru.

Ответ:

```javascript
db.posts.insertMany([
    {creation_date: new Timestamp, author: "skbx@example.com", topics: ["mongodb"]},
    {creation_date: ISODate("2021-12-31T00:00:00.000Z"), author: "skbx@example.com"}
]);
```

### Задание 3

Создайте композитный индекс для коллекции users, в него войдут поля first_name и last_name.
Приведите запросы: на создание индекса и на проверку, что индекс используется.

Ответ:

```javascript
db.users.createIndex({first_name: 1, last_name: 1});
db.users.find({first_name: "Abahri", last_name: "Alfred"}).explain();
```

### Задание 4

Посчитайте сумму кармы по первым буквам имён пользователей для тех пользователей, у которых больше 300 визитов.

Ответ:

```javascript
db.users
    .aggregate([
        {$match: {visits: {$gt: 300}}},
        {
            $project: {
                karma: "$karma",
                visits: "$visits",
                first_letters: {$substr: ["$first_name", 0, 1]}
            }
        },
        {$group: {_id: "$first_letters", summ_karma: {$sum: "$karma"}}},
        {$sort: {_id: 1}}
    ]);
```

### Задание 5

Создайте хранимую функцию shuffle,
которая принимает один параметр — строку и возвращает строку со случайно переставленными символами.

Ответ:

```javascript
db.system.js.insertOne({
    _id: "shuffleString", value: function (stringToShuffling) {
        let splittedString = stringToShuffling.split("");
        return splittedString.sort(() => Math.random() - 0.5);
    }
});
```
