WITH unique_senders AS (SELECT DISTINCT user_from_id FROM skillboxdb.user_private_message)
SELECT user_from_id,
       (SELECT COUNT(1)
        FROM skillboxdb.user_private_message
        WHERE user_from_id = unique_senders.user_from_id) AS message_count
FROM unique_senders
ORDER BY user_from_id;

SELECT user_from_id, COUNT(1) AS message_count
FROM user_private_message
GROUP BY user_from_id
ORDER BY user_from_id;



SELECT first_name, SUBSTRING(first_name, 1, 1)
FROM user
ORDER BY first_name;


SELECT SUBSTRING(first_name, 1, 1) AS word,
       COUNT(1)                    AS cnt
FROM user
GROUP BY word
ORDER BY cnt DESC;


SELECT user_from_id,
       user_to_id,
       MIN(send_time),
       MAX(send_time)
FROM user_private_message
GROUP BY user_from_id, user_to_id;


SELECT *
FROM (SELECT group_id, COUNT(1) AS cnt FROM users_to_discussion_groups GROUP BY group_id) q
WHERE cnt > 5;

SELECT group_id,
       COUNT(1) AS cnt
FROM users_to_discussion_groups
GROUP BY group_id
HAVING cnt > 2
ORDER BY cnt;


-- -----------------------------------
SELECT user_id,
       group_id,
       COUNT(1) AS cnt
FROM skillboxdb.user_group_post
WHERE creation_time > SUBDATE(NOW(), INTERVAL 4 YEAR)
GROUP BY user_id, group_id
HAVING cnt > 1
ORDER BY 2, 3 DESC
;

SELECT DATE_SUB(NOW(), INTERVAL 2 YEAR);
SELECT SUBDATE(NOW(), INTERVAL 2 YEAR);
SELECT NOW();
SELECT CURRENT_TIMESTAMP();


-- ---------------
SELECT DISTINCT group_id,
                COUNT(1) AS cnt
FROM skillboxdb.user_group_post
GROUP BY group_id, user_id
HAVING cnt = 2
ORDER BY group_id;



SELECT user_id,
       COUNT(1) AS cnt
FROM user_group_post
GROUP BY user_id
ORDER BY cnt DESC
LIMIT 10;


SELECT AVG(cnt)
FROM (SELECT COUNT(1) AS cnt
      FROM user_group_post
      GROUP BY user_id
      ORDER BY cnt DESC
      LIMIT 10) AS t
;

-- ид пользователя и  среднее количество сообщений этого пользователя
SELECT user_id,
       COUNT(1) AS message_count
FROM user_group_post
GROUP BY user_id
ORDER BY message_count DESC;



WITH avgs AS (SELECT group_id, AVG(cnt) AS avg
              FROM (SELECT group_id, user_id, COUNT(1) AS cnt FROM user_group_post GROUP BY user_id, group_id) AS cnts
              GROUP BY group_id)
SELECT group_id,
       user_id,
       COUNT(1) AS cnt
FROM user_group_post
WHERE creation_time > SUBDATE(NOW(), INTERVAL 4 YEAR)
GROUP BY group_id, user_id
HAVING cnt > (SELECT avg FROM avgs WHERE avgs.group_id = user_group_post.group_id)
ORDER BY group_id, 1;

--
-- одинаковые запросы по смыслу
--


WITH cnts AS (SELECT group_id,
                     user_id,
                     COUNT(1) AS cnt
              FROM user_group_post
              WHERE creation_time > SUBDATE(NOW(), INTERVAL 4 YEAR)
              GROUP BY group_id, user_id),
     avgs AS (SELECT group_id, AVG(cnt) AS avg FROM cnts GROUP BY group_id)
SELECT group_id, user_id, cnt
FROM cnts
WHERE cnt > (SELECT avg FROM avgs WHERE avgs.group_id = cnts.group_id)
ORDER BY group_id, 1

