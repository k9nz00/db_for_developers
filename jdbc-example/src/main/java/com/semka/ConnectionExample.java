package com.semka;

import java.sql.*;

public class ConnectionExample {
    public static void main(String[] args) throws SQLException {
        String url = "jdbc:mysql://localhost:3306/skillboxdb";
        String user = "skillbox";
        String password = "skillbox";

        try (Connection connection = DriverManager.getConnection(url, user, password)) {
            PreparedStatement preparedStatement = connection.prepareStatement("SELECT * FROM user WHERE user_id = ? ");
            preparedStatement.setInt(1, 7545);

            ResultSet resultSet = preparedStatement.executeQuery();
            if (resultSet.next()) {
                String firstName = resultSet.getString("first_name");
                String lastName = resultSet.getString("first_name");
                int userId = resultSet.getInt("user_id");
                String userInfo = String.format("%d %s %s", userId, firstName, lastName);
                System.out.println(userInfo);
            }
        }
    }
}