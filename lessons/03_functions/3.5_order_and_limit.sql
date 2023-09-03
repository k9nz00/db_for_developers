-- order by
SELECT user_id, login, registration_time
FROM skillboxdb.user
ORDER BY user_id;
SELECT message_id, is_read, send_time, read_time
FROM skillboxdb.user_private_message
ORDER BY is_read ASC, message_id DESC;

-- limit
SELECT user_id, login, registration_time
FROM skillboxdb.user
ORDER BY user_id
LIMIT 10;

-- если limit используется с двемя аргументами, то первый аргумент это смещение относительно resultSet. Используется для пагинации
SELECT user_id, login, registration_time
FROM skillboxdb.user
ORDER BY user_id
LIMIT 10, 10;

SELECT user_id, login, registration_time
FROM skillboxdb.user
ORDER BY user_id
LIMIT 20, 10;