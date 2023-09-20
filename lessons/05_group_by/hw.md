### Задание 1

Составьте запрос, выбирающий количество дней между самым ранним и самым поздним постами
в user_group_post в разрезе типов поста (post_type).
Результаты отсортируйте по количеству дней от большего к меньшему.

Ответ

```sql
SELECT post_type,
       COUNT(1)                                         AS post_type_count,
       DATEDIFF(MAX(creation_time), MIN(creation_time)) AS diff_count_days
FROM skillboxdb.user_group_post
GROUP BY post_type
ORDER BY diff_count_days DESC;
```

### Задание 2

Составьте SQL запрос, который выбирает количество активных (is_active) пользователей
в разрезе типов регистраций (registration_type).
В результатах должны быть отфильтрованы только те типы,
самая ранняя регистрация в которых произошла позже 1 июня 2018 года.
Запрос должен возвращать информацию только об одном типе ― с наибольшим количеством пользователей.

Ответ

```sql
SELECT registration_type,
       COUNT(1) AS active_user_count
FROM (SELECT registration_type FROM user WHERE is_active IS TRUE AND registration_time > '2018-06-01') AS t
GROUP BY registration_type
ORDER BY active_user_count DESC
LIMIT 1;
```

### Задание 3

Напишите SQL запрос, который выбирает даты отправки личных сообщений,
в которые любой из отправивших сообщения сделал это только один раз в этот день.

Ответ

```sql
WITH not_valid_days AS (SELECT DATE(send_time) AS send_time_date, COUNT(message_id) AS cnt
                        FROM user_private_message
                        GROUP BY user_from_id, send_time_date
                        HAVING cnt > 1)
SELECT DISTINCT DATE(send_time) AS unique_day
FROM user_private_message
WHERE DATE(send_time) NOT IN (SELECT send_time_date FROM not_valid_days)
ORDER BY unique_day
```

### Задание 4

Проверить понимание принципов выбора первичных ключей.

Ответьте на следующие вопросы:

1. Может ли у первичного ключа быть несколько одинаковых значений в одной таблице? Почему?
2. Может ли в таблице быть несколько ключей? Почему?
3. Что такое UUID? В каких случаях UUID удобнее использовать для первичного ключа?
4. Что делает auto_increment для поля в таблице? Зачем нужен этот механизм?

Ответы

1. У первичного ключа может быть только одно значение.
   При определении первчного ключа СУБД накдывает ограничение UNIQUE для этого поля.
2. В таблице может быть только один первичный ключ. Благодаря ему можно однозначно идентифицировать конкретную запись в
   таблице.
3. Universally Unique Identifier (UUID) это уникальное текстовое значение, часто используемое в качестве первичного
   ключа. Удобно использовать в случае кластерной распределенной системы, чтобы снизить ресурсные затраты на вычисление
   автоинкрементного PK.
4. Механизм auto_increment увеличивает значение некоторого поля, используемого в последовательности, на определенное
   значение. Чаще всего на 1. Auto_increment предоставляет собой удобный инструмент, для получения уникального значение
   для PK. 
 