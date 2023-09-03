-- Из всех операций над множествами mysql поддерживает только UNION или UNION ALL
SELECT user_to_id
FROM user_private_message
UNION
SELECT user_from_id
FROM user_private_message