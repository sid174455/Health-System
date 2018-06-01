package com.java.database;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class DatabaseConnection {

	String db = "health";
	String username = "root";
	String password= "pasighat";
	
	Connection con = null;
    Statement stmt;
    ResultSet rs = null;
    
    public DatabaseConnection() {
    	
    }
    
    public Connection dbconnection() {

        try {
            String url = "jdbc:mysql://localhost/" + db;
            Class.forName("com.mysql.jdbc.Driver").newInstance();

            con = DriverManager.getConnection(url, username, password);
               
        } catch (Exception ex) {
            ex.printStackTrace();
        
        }
        return con;
    }
    
    
    public ResultSet getResultSet(String query) {
        try {
            stmt = con.createStatement();
            rs = stmt.executeQuery(query);
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return rs;
    }
    
    public int getUpdate(String query) {
        int i = 0;
        try {
            stmt = con.createStatement();
            i = stmt.executeUpdate(query);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return i;
    }
    
    public void closeConnection(DatabaseConnection dbcon)
    {
        try {
            dbcon.dbconnection().close();
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
    }
    
}
