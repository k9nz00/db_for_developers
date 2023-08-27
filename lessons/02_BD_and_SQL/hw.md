### Задание 1

Опишите структуру таблицы discussion_group:

* какие в таблице есть колонки и каких типов?
* какие колонки могут принимать значение null?
* какие ограничения на размер значений есть для различных колонок?

### Ответ к заданию 1

#### Какие в таблице есть колонки и каких типов?

SQL-выражение для получения имен колонок и их типов

```sql
SELECT COLUMN_NAME AS name,
       COLUMN_TYPE AS type
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = 'skillboxdb'
  AND TABLE_NAME = 'discussion_group';
```

Результат выполнения SQL-выражение

| name             | type         |
|:-----------------|:-------------|
| group_id         | int unsigned |
| creation_time    | timestamp    |
| name             | varchar(255) |
| description      | text         |
| group_tags       | json         |
| admin_user_id    | int unsigned |
| approve_required | tinyint(1)   |

#### Какие колонки могут принимать значение null?

SQL-выражение для получения имен позволяющих принимать значение null

```sql
SELECT COLUMN_NAME AS name
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = 'skillboxdb'
  AND TABLE_NAME = 'discussion_group'
  AND IS_NULLABLE = 'YES';
```

Только одно поле позволяет принимать NULL значение - `description`

#### Какие ограничения на размер значений есть для различных колонок?

SQL-выражение для получения колонок, у которых есть ограничения на размер данных

```sql
SELECT COLUMN_NAME              AS name,
       COLUMN_TYPE              AS type,
       CHARACTER_MAXIMUM_LENGTH AS max_length
FROM information_schema.COLUMNS
WHERE TABLE_SCHEMA = 'skillboxdb'
  AND TABLE_NAME = 'discussion_group'
  AND COLUMN_NAME IN ('group_id', 'name', 'description', 'admin_user_id', 'approve_required');
```

Ограничения на размер данных. Данные для столбца "max_length" взяты из оффициальной документации

| name             | type         | max_length         |
|:-----------------|:-------------|:-------------------|
| group_id         | int unsigned | от 0 до 4294967295 |
| name             | varchar(255) | от 0 до 255        |
| description      | text         | от 0 до 65535      |
| admin_user_id    | int unsigned | от 0 до 4294967295 |
| approve_required | tinyint(1)   | от -128 до 127     |

### Ответ к заданию 2

Из таблицы пользователей выберите логин пользователя и тип регистрации,
переименуйте колонки следующим образом: `user_login`, `sign_on_with`.
Ответ предоставьте в виде выполняемого запроса к СУБД MySQL.

Ответ

```sql
SELECT login             AS user_login,
       registration_type AS sign_on_with
FROM skillboxdb.user
```

### Ответ к заданию 3

Выберите все дискуссионные группы, в которых требуется подтверждение (аппрув).
Ответ предоставьте в виде выполняемого запроса к СУБД MySQL.

Ответ

```sql
SELECT *
FROM skillboxdb.discussion_group
WHERE approve_required IS TRUE;
```

### Ответ к заданию 4

Выберите все дискуссионные группы, созданные в 2018 году. Ответ предоставьте в виде выполняемого запроса к СУБД MySQL.

Ответ

```sql
SELECT *
FROM skillboxdb.discussion_group
WHERE YEAR(creation_time) = 2018
ORDER BY creation_time;
```

### Ответ к заданию 5

Выберите данные из `user_group_post` по следующим условиям:
* тип поста — pinned и пост создан либо в 2018 году, либо в 2020;
* тип поста — default и пост создан в 2019.

Ответ предоставьте в виде выполняемого запроса к СУБД MySQL.

Ответ:
```sql
SELECT *
FROM skillboxdb.user_group_post
WHERE post_type = 'pinned' AND
      (creation_time BETWEEN '2018-01-01' AND '2018-12-31' OR creation_time BETWEEN '2020-01-01' AND '2020-12-31')
   OR post_type = 'default' AND creation_time BETWEEN '2019-01-01' AND '2019-12-31';
```