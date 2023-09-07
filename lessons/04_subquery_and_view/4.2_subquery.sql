-- пример подзапросов в блоке спецификации столбца в выражении SELECT
-- в данном случае подзапрос должен вернуть только одно значение
-- подзапросов может быть неограниченное количество
-- ------------
SELECT group_id,
       name,
       (SELECT CONCAT(first_name, ' ', last_name) FROM user WHERE admin_user_id = user.user_id) AS full_name
FROM discussion_group
ORDER BY group_id;

-- аналогичной запрос как и выше, сделанный через  join
SELECT group_id, name, CONCAT(first_name, ' ', last_name) AS full_name
FROM discussion_group dg
         INNER JOIN skillboxdb.user u ON dg.admin_user_id = u.user_id
ORDER BY group_id;
-- -----------

-- запрос с дополнительным полем в результатах выборки.
-- Особенность такого типа запроса в том, что для каждого кортежа из основной таблицы будет выполнен подзапрос
-- на этапе формирования итогового резулсета. Уменьшить количество ненужных подзапросов можно добовив условие фильтрации
-- в основной запрос
SELECT group_id,
       name,
       (SELECT CONCAT(first_name, ' ', last_name) FROM user WHERE admin_user_id = user.user_id) AS full_name,
       (SELECT login FROM user WHERE admin_user_id = user.user_id)                              AS admin_login
FROM discussion_group
ORDER BY group_id;


-- пример с неоднозначностью условий выборки при совпадении имен колонок в разных таблицах
-- ошибка
SELECT post_id, post_text, (SELECT login FROM user WHERE user_id = user_id) AS login
FROM user_group_post;

-- корректный запрос
SELECT post_id, post_text, (SELECT login FROM user WHERE user_group_post.user_id = user.user_id) AS login
FROM user_group_post;


-- примеры подзапросов в условии в выражении WHERE
SELECT message_id, user_to_id
FROM user_private_message
WHERE (SELECT email FROM user WHERE user_to_id = user.user_id) = 'cwby1996@gmail.com'

SELECT *
FROM skillboxdb.user
WHERE EXISTS(SELECT 1 FROM skillboxdb.discussion_group WHERE user.user_id = discussion_group.admin_user_id);


-- пример использования функции exists
SELECT EXISTS(SELECT 1 FROM user WHERE user_id = 7490);


--
SELECT *
FROM user_private_message
WHERE send_time BETWEEN (SELECT MIN(creation_time) AS min_time
                         FROM user_group_post
                         WHERE group_id = 570764) AND (SELECT MAX(creation_time) AS max_time
                                                       FROM user_group_post
                                                       WHERE group_id = 570764);
--

WITH times AS (SELECT MIN(creation_time) AS min_time,
                      MAX(creation_time) AS max_time
               FROM user_group_post
               WHERE group_id = 570848)
SELECT *
FROM user_private_message
WHERE send_time BETWEEN (SELECT min_time FROM times) AND (SELECT max_time FROM times);


-- примеры подзапросов в выражении ORDER BY
SELECT post_id,
       user_id,
       (SELECT login FROM user WHERE user_group_post.user_id = user.user_id) AS login
FROM user_group_post
ORDER BY (SELECT login FROM user WHERE user_group_post.user_id = user.user_id) ASC, post_id;



-- примеры подзапросов в качестве таблицы для выборки в выражении FROM
-- при таком использовании обязательно указывать алиас "временной таблицы"
SELECT *
FROM (SELECT * FROM user WHERE is_active IS TRUE) AS active_users
WHERE registration_type = 'vk';