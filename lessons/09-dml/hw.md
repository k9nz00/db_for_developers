### Задание 1

Добавьте новую дискуссионную группу с названием Databases for programmers, а администратором назначьте последнего
зарегистрированного пользователя. Задание нужно сделать одним запросом.

Ответ

```sql
INSERT INTO discussion_group (creation_time, name, description, group_tags, admin_user_id, approve_required)
VALUES (NOW(),
        'Databases for programmers',
        'description for group \'Databases for programmers\'',
        '[
          "skillbox",
          "mysql"
        ]',
        (SELECT user_id FROM user ORDER BY registration_time DESC LIMIT 1),
        FALSE);
```

### Задание 2

Добавьте всех пользователей в группу, созданную в первом задании. Укажите approved=0.

Ответ

```sql
INSERT INTO users_to_discussion_groups (user_id, group_id, joined_time, approved, approved_time)
    (SELECT user_id,
            (SELECT group_id FROM discussion_group WHERE name = 'Databases for programmers'),
            NOW(),
            0,
            NULL
     FROM user);
```

### Задание 3

Для всех добавленных в задании пользователей обновите поле approved=1 и approved_time ― текущее время.

Ответ

```sql
WITH user_group AS (SELECT utdg.user_id  AS user_id,
                           utdg.group_id AS group_id
                    FROM user u
                             JOIN users_to_discussion_groups utdg ON u.user_id = utdg.user_id
                             JOIN discussion_group dg ON dg.group_id = utdg.group_id
                    WHERE dg.name = 'Databases for programmers')
UPDATE users_to_discussion_groups utdg2
SET approved      = TRUE,
    approved_time = NOW()
WHERE utdg2.user_id IN (SELECT user_id FROM user_group)
  AND utdg2.group_id IN (SELECT group_id FROM user_group);
```

### Задание 4

Удалите все созданные в заданиях 1-2 записи одним запросом.

Ответ

```sql
DELETE dg, utdg
FROM discussion_group dg
         INNER JOIN users_to_discussion_groups utdg ON dg.group_id = utdg.group_id
WHERE dg.name = 'Databases for programmers';
```