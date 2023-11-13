### Задание 1

Укажите такое значение для переменной url, чтобы следующий код присоединился к серверу MySQL со следующими параметрами:

* хост — mysql.example.com
* порт — 3307
* пользователь — admin
* пароль — pass

Ответ

```java
public class Main {
    public static void main(String[] args) {
        String url = "jdbc:mysql://mysql.example.com:3307/skillboxdb?user=admin&password=pass";
        Connection conn = DriverManager.getConnection(url2);
    }
}
```

### Задание 2

Для переменной ResultSet resultSet выведите значение поля first_name, если в результатах есть хотя бы одна запись. Если
в результатах нет ни одной записи, выведите Empty set.

Ответ

см код `jdbc-example/src/main/java/com/semka/ConnectionExample.java:15`

### Задание 3

Для класса UserDao, приведённого в уроке, напишите метод public User getUser(int userId), который возвращает объект User
с соответствующим userId или null, если такого пользователя нет в БД.

Ответ

см код `jdbc-orm/src/main/java/com/semka/dao/impl/UserDaoImpl.java:38`

### Задание 4

Для класса UserDao, приведённого в уроке, напишите метод public void activateUser(int userId), который внутри одной
транзакции устанавливает is_active в таблице равным единице, если он не был таковым, сохраняет объект и коммитит
транзакцию. Если пользователь не найден или is_active уже равен единице, то следует откатить транзакцию.

Ответ

см код `jdbc-orm/src/main/java/com/semka/dao/impl/UserDaoImpl.java:51`