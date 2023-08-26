USE skillboxdb;

DESCRIBE discussion_group;
SELECT * FROM discussion_group;

-- простая выборка всех  полей
SELECT * FROM user;

-- простая выборка  полей с указанием имен требуемых полей
SELECT user_id, login, email FROM user;

-- простая выборка полей с указанием имен требуемых полей с указанием имени колонки в result set (с пробелом и черех AS)
SELECT user_id id, login, password_hash password FROM user;
SELECT user_id AS id, login, password_hash AS password FROM user;

-- FROM не обязательное слово в mysql диалекте
SELECT 1; -- может применяться как диагностическое выражение для проверки корректности параметров подключения
SELECT 1 result; -- тоже самое, но с указанием имени колонки результата
SELECT 1+1 AS result; -- как "калькулятор" для рассчета результатов выражения