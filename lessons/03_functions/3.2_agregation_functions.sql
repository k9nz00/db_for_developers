SELECT count(*) FROM skillboxdb.user;
SELECT sum(user_id) FROM skillboxdb.user;
SELECT max(user_id) FROM skillboxdb.user;
SELECT min(user_id) FROM skillboxdb.user;
SELECT avg(user_id) FROM skillboxdb.user;
SELECT count(read_time) FROM user_private_message;
SELECT count(*) FROM user_private_message WHERE read_time IS NOT NULL;