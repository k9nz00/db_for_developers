-- Подзапросы в конструкции 'WITH' всегда выполняются ДО основного запроса
-- и сохраняются во временной таблице.

WITH active_users AS (SELECT * FROM skillboxdb.user WHERE is_active = TRUE)
SELECT COUNT(*)
FROM active_users;

WITH active_users AS (SELECT * FROM skillboxdb.user WHERE is_active = TRUE),
     google_active_users AS (SELECT * FROM active_users WHERE registration_type = 'google')

SELECT google_active_users.user_id
FROM google_active_users;

-- если не ограничить данный подзапрос, то из-за того что он выполняется первым, основной запрос никогда не выполнится
-- из-за бесконечной рекурсии.
-- числа фибоначи
WITH RECURSIVE fibo (n, fib_n, next_fib) AS (SELECT 1, 0, 1
                                             UNION ALL
                                             SELECT n + 1, next_fib, fib_n + next_fib
                                             FROM fibo
                                             WHERE n < 20)
SELECT *
FROM fibo;