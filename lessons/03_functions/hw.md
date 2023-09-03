### Задание 1

Напишите SQL-запрос «выбрать всех пользователей». В результатах должны быть три колонки:

* идентификатор пользователя;
* is_vk_type со значениями '+', если тип регистрации vk, и '-', если какой-либо другой;
* full_name — имя, логин и фамилия пользователя одним полем в формате 'имя фамилия (логин)'.

Ответ
```sql
SELECT user_id,
       IF(registration_type = 'vk', '+', '-')               AS is_vk_type,
       CONCAT(first_name, ' ', last_name, ' (', login, ')') AS full_name
FROM skillboxdb.user;
```

### Задание 2

Одним SQL-запросом выберите для таблицы users_to_discussion_groups:

* approved_cnt — количество подтверждений присоединения к группам,
* oldest_join — наиболее раннюю дату присоединения пользователя к группе,
* recent_approve — дату наиболее позднего подтверждения участника в группе.

Ответ
```sql
SELECT SUM(approved)      AS approved_cnt,
       MIN(joined_time)   AS oldest_join,
       MAX(approved_time) AS recent_approve
FROM skillboxdb.users_to_discussion_groups;
```

### Задание 3

Напишите SQL-запрос, который выбирает второй тег из списка тегов групп (таблица discussion_group).

Ответ
```sql
SELECT JSON_EXTRACT(group_tags, '$[1]')
FROM skillboxdb.discussion_group;
```

### Задание 4

Напишите SQL-запрос, который выбирает уникальные идентификаторы пользователей 
среди администраторов групп и отправителей приватных сообщений.

Ответ
```sql
SELECT admin_user_id
FROM skillboxdb.discussion_group
UNION
SELECT user_from_id
FROM skillboxdb.user_private_message;
```

### Задание 5

Напишите SQL-запрос, который выбирает 20 последних зарегистрированных пользователей. 
Поля в результатах выборки: user_id, registration_time.

Ответ
```sql
SELECT user_id, registration_time
FROM skillboxdb.user
ORDER BY registration_time DESC
LIMIT 20
```