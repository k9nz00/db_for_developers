### Задание 1

Выберите пользовательские мейлы и отправленные пользователям сообщения. Если у пользователя нет ни одного полученного
сообщения, то всё равно укажите его мейл и в соответствующих полях сообщения укажите null.

В результатах должны быть следующие колонки: email, message_id, read_time.

Ответ

```sql
SELECT email, message_id, read_time
FROM user u
         LEFT JOIN skillboxdb.user_private_message upm ON u.user_id = upm.user_from_id
ORDER BY email;
```

### Задание 2

Соедините таблицы users_to_discussion_groups и user_group_post по group_id так, чтобы в результатах были колонки
creation_time из обеих таблиц. Если в какой-либо из таблиц нет соответствия, то в полях этой таблицы должны быть указаны
null. Поле group_id должно быть заполнено всегда из первой или второй таблицы.

Ответ

```sql
SELECT utdg.group_id, ugp.creation_time
FROM users_to_discussion_groups utdg
         LEFT JOIN user_group_post ugp ON utdg.group_id = ugp.group_id
UNION
SELECT utdg.group_id, ugp.creation_time
FROM users_to_discussion_groups utdg
         RIGHT JOIN user_group_post ugp ON utdg.group_id = ugp.group_id;
```

### Задание 3

В нашей БД пользователи могут отправлять сообщения друг другу, то есть таблица пользователей связана сама с собой как
Many:Many. Выберите пары логинов пользователей, связывая их транзитной таблицей личных сообщений.

Ответ

```sql
SELECT DISTINCT u1.login AS writer, u2.login AS reader
FROM user_private_message upm
         INNER JOIN user u1 ON upm.user_from_id = u1.user_id
         INNER JOIN user u2 ON upm.user_to_id = u2.user_id;
```

### Задание 4

Выберите топ-10 пользователей, которые зарегистрировались, когда на форумах было больше всего сообщений. В результатах
укажите логин пользователя, количество сообщений, которое было на форуме до момента регистрации пользователя, суммарную
длину всех этих сообщений.

Ответ

```sql
SELECT login,
       COUNT(ugp.post_id)     AS post_count_before_registration,
       SUM(LENGTH(post_text)) AS total_messages_length
FROM user u
         INNER JOIN user_group_post ugp ON u.registration_time > ugp.creation_time
GROUP BY login
ORDER BY post_count_before_registration DESC
LIMIT 10;
```


