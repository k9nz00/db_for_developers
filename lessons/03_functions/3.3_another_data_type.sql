-- json in MySql
SELECT user_id, login, metadata, json_extract(metadata, '$.default_theme') FROM skillboxdb.user;