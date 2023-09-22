### Задание 1

Что нужно сделать
Для каждого случая по описанию укажите тип связи: 1:1, 1:Many, Many:Many

Как связаны:

1. Таблица одноразовых билетов на поезд с поездом.
2. Таблица тегов к постам в социальной сети.
3. Таблица сотрудников компании и информация об их окладе

Ответы

1. 1:1
2. Many:Many
3. 1:Many

### Задание 2

Что нужно сделать
Для таблиц user_group_post, user_private_message и users_to_discussion_groups укажите список атрибутов внешних ключей
и с какими таблицами они связаны.
Ответ

```sql
SELECT CONSTRAINT_NAME,
       TABLE_NAME,
       COLUMN_NAME,
       REFERENCED_TABLE_NAME,
       REFERENCED_COLUMN_NAME
FROM information_schema.KEY_COLUMN_USAGE
WHERE TABLE_NAME IN ('user_group_post', 'user_private_message', 'users_to_discussion_groups')
  AND CONSTRAINT_NAME NOT LIKE '%PRIMARY%';
```

### Задание 3

Что нужно сделать
Составить 4 запроса:

1. Удалите первичный ключ из таблицы user
2. Сделайте login первичным ключом в таблице user
3. Удалите внешний ключ users_to_discussion_groups.user_id
4. Добавьте тот же ключ снова, внешний ключ должен каскадно удалять записи.

Ответ

1.

```sql
ALTER TABLE user_group_post
    DROP FOREIGN KEY user_group_post_ibfk_1;
ALTER TABLE users_to_discussion_groups
    DROP FOREIGN KEY users_to_discussion_groups_ibfk_1;
ALTER TABLE discussion_group
    DROP FOREIGN KEY discussion_group_ibfk_1;
ALTER TABLE user_private_message
    DROP FOREIGN KEY user_private_message_ibfk_1;
ALTER TABLE user_private_message
    DROP FOREIGN KEY user_private_message_ibfk_2;
ALTER TABLE skillboxdb.user
    DROP PRIMARY KEY,
    CHANGE user_id user_id int UNSIGNED;
```

2.

```sql
ALTER TABLE user
    ADD PRIMARY KEY (login);
```

3.

```sql
ALTER TABLE users_to_discussion_groups
    DROP FOREIGN KEY users_to_discussion_groups_ibfk_2;
```

4.

```sql
ALTER TABLE user
    ADD CONSTRAINT user_user_id_uniq UNIQUE (user_id);
ALTER TABLE users_to_discussion_groups
    ADD CONSTRAINT users_to_discussion_groups_ibfk_2 FOREIGN KEY (user_id) REFERENCES user (user_id) ON DELETE CASCADE;
```

### Задание 4

Что нужно сделать
Составить запрос, выбирающий название группы на форуме и логин ее администратора.

Ответ

```sql
SELECT login, name
FROM user u
         INNER JOIN discussion_group dg ON u.user_id = dg.admin_user_id;
```

### Задание 5

Что нужно сделать
Составьте запрос, выбирающий логин пользователя и количество отправленных им личных сообщений,
если пользователь отправлял хотя бы одно сообщение.

Ответ

```sql
SELECT login, COUNT(1) AS cnt
FROM user u
         INNER JOIN user_private_message upm ON u.user_id = upm.user_from_id
GROUP BY u.user_id
HAVING cnt > 1
ORDER BY cnt DESC;
```