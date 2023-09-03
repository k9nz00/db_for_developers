-- coalesce() - возвращает первый не null аргумент соответствующей строки
SELECT user_id, last_name, COALESCE(registration_time, date_of_birth)
FROM skillboxdb.user;
SELECT message_id, COALESCE(read_time, send_time) AS exists_time_value
FROM user_private_message;

-- if функция ветвления
SELECT message_id, is_read, read_time, if(is_read, 'прочитано', 'непрочитано') FROM user_private_message;

-- MySQL функция GREATEST возвращает наибольшее значение в списке выражений.
SELECT message_id, GREATEST(COALESCE(read_time, send_time), (CURDATE()))
FROM user_private_message;
SELECT GREATEST(1, 2, 3) AS greatest_result;
SELECT GREATEST('March', 'April', 'May');
SELECT GREATEST(CAST('March' AS CHAR), CAST('April' AS CHAR), CAST('May' AS CHAR));

-- MySQL функция CONCAT позволяет объединять вместе два или более выражений
SELECT user_id, CONCAT(first_name, ' ', last_name)
FROM skillboxdb.user
ORDER BY user_id;

-- функции для работы с датой
SELECT CURDATE(); -- текущая дата
SELECT CURTIME(); -- текущее время
SELECT NOW(); -- текущая метка времени
SELECT user_id,
       CONCAT(first_name, ' ', last_name),
       YEAR(registration_time),
       MONTH(registration_time),
       MONTHNAME(registration_time),
       DAY(registration_time),
       DAYNAME(registration_time)
FROM skillboxdb.user
WHERE user_id = (SELECT MIN(user_id) FROM skillboxdb.user);

-- другие функции смотреть в документации
-- https://metanit.com/sql/mysql/6.4.php - еще примеры работы с функциями