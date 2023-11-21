### Задание 1

Напишите последовательность команд для Redis:

* Создайте ключ index со значением “index precalculated content”.
* Проверьте, есть ли ключ index в БД.
* Узнайте, сколько ещё времени будет существовать ключ index.
* Отмените запланированное удаление ключа index.

Ответ:

```redis
SET index "index precalculated content" EX 60
EXISTS index
TTL index
PERSIST index
```

### Задание 2

Напишите последовательность команд для Redis:

- Создайте в Redis структуру данных с ключом ratings для хранения следующих значений рейтингов технологий:
    * mysql — 10,
    * postgresql — 20,
    * mongodb — 30,
    * redis — 40.
- По этому же ключу увеличьте значение рейтинга mysql на 15.
- Удалите из структуры элемент с максимальным значением.
- Выведите место в рейтинге для mysql.

Ответ:

```redis
ZADD ratings 10 mysql
ZADD ratings 20 postgresql
ZADD ratings 30 mongodb
ZADD ratings 40 redis
ZINCRBY ratings 15 mysql
ZPOPMAX ratings
ZMSCORE ratings mysql
```

### Задание 3

Напишите две команды для СУБД Redis:

* Подпишитесь на все события, опубликованные на каналах, начинающихся с events.
* Опубликуйте сообщение на канале events101 с текстом “Hello there”.

Ответ:

```redis
PSUBSCRIBE events*
PUBLISH events101 "Hello there"
```

### Задание 4

Сохраните в Redis функцию, которая принимает ключ и значение и сохраняет под указанным ключом квадратный корень от
значения.

Ответ:

```redis
SCRIPT LOAD "redis.call('set', 'calculate:'..KEYS[1]..':multiple', ARGV[1] * ARGV[1])"

-- bf4c3933cfca0656abb5d07fcfa9fb30e73b170c
EVALSHA bf4c3933cfca0656abb5d07fcfa9fb30e73b170c 1 1 5

GET calculate:1:multiple
```