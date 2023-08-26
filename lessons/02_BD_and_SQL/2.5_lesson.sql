-- статья с описанием типов данных в MySQL
--https://metanit.com/sql/mysql/2.3.php

USE skillboxdb;

-- фильтрация данных производится при помощи ключевого слова WHERE
SELECT * FROM user WHERE user_id > 10;

-- комбинация условий возможна при помощи ключевых слов OR или AND
SELECT * FROM user WHERE user_id > 10 AND is_active = true;
SELECT * FROM user WHERE (user_id > 10 AND is_active = true) OR email LIKE 'bc%';

