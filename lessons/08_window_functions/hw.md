### Задание 1

Выберите идентификаторы запиненных постов и укажите их порядковые номера, сортируя по дате создания.

Ответ

```sql
SELECT post_id,
       ROW_NUMBER() OVER (PARTITION BY creation_time) as pinned_post_row_number
FROM user_group_post
ORDER BY creation_time
```