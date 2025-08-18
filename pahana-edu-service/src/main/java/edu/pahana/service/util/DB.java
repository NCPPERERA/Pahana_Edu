package edu.pahana.service.util;

import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.util.Properties;

public class DB {
    private static Connection connection;

    public static Connection get() throws Exception {
        if (connection == null || connection.isClosed()) {
            Properties p = new Properties();
            try (InputStream in = DB.class.getClassLoader().getResourceAsStream("db.properties")) {
                p.load(in);
            }
            
            
            String url = p.getProperty("db.url");
            String user = p.getProperty("db.user");
            String pass = p.getProperty("db.password");
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, user, pass);
        }
        return connection;
    }
}


