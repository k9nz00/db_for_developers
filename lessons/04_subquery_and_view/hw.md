### Задание 1

Напишите SQL-запрос, который удовлетворяет следующим критериям:

1. В запросе в секции WITH указаны два подзапроса:
    * groups_with_approve — выбирает группы, в которых требуется подтверждение;
    * new_groups — группы, созданные в 2020 году или позже, в которых требуется подтверждение.
2. Между подзапросами groups_with_approve и new_groups есть зависимость.
3. В основном запросе происходит выборка всего из new_groups.

Ответ

```sql
WITH groups_with_approve AS (SELECT * FROM skillboxdb.discussion_group WHERE approve_required = TRUE),
     new_groups AS (SELECT * FROM groups_with_approve WHERE YEAR(creation_time) >= 2020)
SELECT *
FROM new_groups;
```

### Задание 2

Напишите SQL-запрос, который удовлетворяет следующим критериям:

1. Из discussion_group выбраны те группы, администратор которых хотя бы раз отправлял приватное сообщение.
2. Поля в выборке:
    * group_id,
    * admin_user_id,
    * admin_post_count — количество постов админа этой группы во всех группах;
    * admin_group_post_count — количество постов админа в его группе.
3. Сортирует результаты по логину админа группы.

Ответ

```sql
SELECT group_id,
       admin_user_id,
       (SELECT COUNT(post_id) FROM skillboxdb.user_group_post WHERE admin_user_id = user_id) AS admin_post_count,
       (SELECT COUNT(post_id)
        FROM user_group_post
        WHERE user_group_post.group_id = discussion_group.group_id
          AND admin_user_id = user_id)                                                       AS admin_group_post_count
FROM skillboxdb.discussion_group
WHERE EXISTS(SELECT 1 FROM skillboxdb.user_private_message WHERE user_to_id = admin_user_id)
ORDER BY (SELECT login FROM user WHERE user_id = discussion_group.admin_user_id);
```

### Задание 3

Напишите SQL-запросы:

1. Создание или обновление представления groups_with_approve из первого задания.
2. Создание или обновление представления new_groups из первого задания, которое использует представление
   groups_with_approve.
3. Запрос на удаление представления groups_with_approve из СУБД.

Ответ

```sql
CREATE OR REPLACE VIEW groups_with_approve AS
WITH groups_with_approve AS (SELECT * FROM skillboxdb.discussion_group WHERE approve_required = TRUE)
SELECT *
FROM groups_with_approve;
```

```sql
CREATE OR REPLACE VIEW new_groups AS
WITH groups_with_approve AS (SELECT * FROM skillboxdb.discussion_group WHERE approve_required = TRUE),
     new_groups AS (SELECT * FROM groups_with_approve WHERE YEAR(creation_time) >= 2020)
SELECT *
FROM new_groups;
```

```sql
DROP VIEW groups_with_approve;
```

### Задание 4

Выберите материализованное или обычное представление для описанных задач.
Если выбрали материализованное представление, укажите частоту обновления данных.
Обоснуйте ответ.

Задачи:

1. Создать представление на основе постоянно обновляющихся данных. Запрос выполняется несколько секунд, данные в
   представлении должны быть всегда актуальными. Из представления будут выбирать данные раз в несколько секунд.
2. Создать представление, из которого можно выбрать статистику продаж по часам. Данные выбираются за любой день кроме
   текущего. Из представления будут выбирать данные десятки раз в час.

Ответ

1. Для первого задания лучше подойдет обычное представление.
   Так как по условиям задачи нужны всегда актуальные данные,
   их следует вычислять на текущей момент времени без использования "кеширования".
   View - это просто сохраненный именованный запрос без стадии сохранения данных на диск.

2. Для решения второй задачи лучше воспользоваться материализованным представлением.
   Данные, необходимые в этом случае, не подлежат устареванию, и однажды рассчитанная статистика
   на конкретный день/час будет актуальна всегда.
   В данном случае частота обновления - раз в сутки в начале дня (00.00)