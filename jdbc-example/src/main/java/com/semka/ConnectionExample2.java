package com.semka;

import java.sql.*;
import java.util.*;
import java.util.stream.Collectors;

public class ConnectionExample2 {
    public static void main(String [] args ){

        Connection conn1 = null;
        Connection conn2 = null;
        Connection conn3 = null;

        try {
            // connect way #1
            String url1 = "jdbc:mysql://localhost:3306/skillboxdb";
            String user = "skillbox";
            String password = "skillbox";

            conn1 = DriverManager.getConnection(url1, user, password);
            if (conn1 != null) {
                System.out.println("Connected to the database way 1");
            }

            // connect way #2
            String url2 = "jdbc:mysql://localhost:3306/skillboxdb?user=skillbox&password=skillbox";
            conn2 = DriverManager.getConnection(url2);
            if (conn2 != null) {
                System.out.println("Connected to the database way 2");
            }

            // connect way #3
            String url3 = "jdbc:mysql://localhost:3306/skillboxdb";
            Properties info = new Properties();
            info.put("user", "skillbox");
            info.put("password", "skillbox");

            conn3 = DriverManager.getConnection(url3, info);
            if (conn3 != null) {
                System.out.println("Connected to the database way 3");
            }

            String query = "SELECT * FROM user WHERE user_id = ?";
            PreparedStatement statement = conn1.prepareStatement(query);
            statement.setString(1, "7490");
            statement.execute();
            ResultSet resultSet = statement.getResultSet();
            if (resultSet.next()) {
                String firstName = resultSet.getString("first_name");
                String lastName = resultSet.getString("last_name");
                System.out.println("Result: " + firstName + " " + lastName);
            } else {
                System.out.println("No results");
            }

            String query2 = "SELECT * FROM user WHERE user_id = ?";
            Map<Integer, String> parameters = new HashMap<>();
            parameters.put(1, "7490");
            String[] fields = new String[] {"first_name", "last_name"};
            printSelectResults(conn1, query2, parameters, fields);

        } catch (SQLException ex) {
            System.out.println("An error occurred. Maybe user/password is invalid");
            ex.printStackTrace();
        }
    }

    private static void printSelectResults(Connection conn, String query, Map<Integer, String> parameters, String[] fields) {
        try {
            PreparedStatement statement = conn.prepareStatement(query);
            for (Map.Entry<Integer, String> entry : parameters.entrySet()) {
                statement.setString(entry.getKey(), entry.getValue());
            }
            statement.execute();
            ResultSet resultSet = statement.getResultSet();
            while (resultSet.next()) {
                System.out.println(Arrays.stream(fields).map(s -> {
                    try {
                        return s + ": " + resultSet.getString(s);
                    } catch (SQLException ex) {
                        return "";
                    }
                }).collect(Collectors.joining(",")));
            }
        } catch (SQLException ex) {
            System.out.println("An error occurred. Maybe user/password is invalid");
            ex.printStackTrace();
        }
    }
}