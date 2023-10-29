### Задание 2

Одним запросом создайте таблицу ban со следующей структурой:

* id — первичный ключ с автоинкрементом
* user_id — внешний ключ к таблице user, не может быть null
* reason — строка: максимум — 200 символов, минимум — 10
* expire — дата и время, значение по умолчанию — сейчас + 1 день

Ответ

```sql
CREATE TABLE ban
(
    id      int          NOT NULL AUTO_INCREMENT,
    user_id int UNSIGNED NOT NULL,
    reason  varchar(200),
    expire  datetime DEFAULT (CURRENT_TIMESTAMP() + INTERVAL 1 DAY),
    PRIMARY KEY (id),
    FOREIGN KEY (user_id) REFERENCES user (user_id),
    CONSTRAINT min_reason_length CHECK ( LENGTH(reason) >= 10 )
);
```

### Задание 3

Одной командой выполните следующие изменения в таблице ban:

1. переименуйте id в ban_id
2. добавьте поле duration с типом целое беззнаковое число, поле должно быть обязательным для заполнения
3. переименуйте поле expire в banned и измените тип поля на date
4. удалите поле reason

Ответ

```sql
ALTER TABLE ban
    CHANGE id ban_id int AUTO_INCREMENT,
    ADD duration int UNSIGNED NOT NULL,
    CHANGE expire banned date DEFAULT ((NOW() + INTERVAL 1 DAY)) NULL,
    DROP COLUMN reason;
```

### Задание 4

Напишите триггер cleanup_message_on_ban, который удаляет последнее личное сообщение,
отправленное пользователем, user_id которого добавлен в таблицу ban.
Если у пользователя нет ни одного сообщения, то ничего удалять не нужно.

Ответ

```sql
CREATE TRIGGER cleanup_message_on_ban
    BEFORE INSERT
    ON ban
    FOR EACH ROW
BEGIN

    WITH last_message_id AS (SELECT message_id
                             FROM user_private_message
                             WHERE user_from_id = NEW.user_id
                             ORDER BY send_time DESC
                             LIMIT 1)
    DELETE
    FROM user_private_message
    WHERE message_id IN (SELECT * FROM last_message_id);
END;
```

### Задание 5

Создайте таблицу reports с полями

* region (строка — до 100 символов)
* revenue (целое число)
* created (дата и время)
* с секционированием (partitioning). Таблица должна быть поделена на 10 секций, секционирование должно проходить по
  значению региона.

Ответ

```sql
CREATE TABLE reports
(
    region  varchar(100) NULL,
    revenue int          NULL,
    created datetime DEFAULT NULL
)
    PARTITION BY KEY (region)
        PARTITIONS 10
```