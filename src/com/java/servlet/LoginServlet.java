package com.java.servlet;

import java.io.IOException;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import AES.AES;

import com.java.database.DatabaseConnection;

/**
 * Servlet implementation class LoginServlet
 */
@WebServlet("/LoginServlet")
public class LoginServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session =request.getSession();
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		try {
			username=AES.encrypt_use(username);
			password=AES.encrypt_use(password);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
		DatabaseConnection db = new DatabaseConnection();
		db.dbconnection();

        
        String sql="Select * from patient where username='"+username+"' and password='"+password+"'";
        ResultSet rs=db.getResultSet(sql);
        try {
				if(rs.next())
				{
					//session.setAttribute("role", "teacher");
					String name=rs.getString("name");
					String id=rs.getString("user_id");
					String key=rs.getString("key1");
					
					String keyname=AES.decrypt_use(key);
					name=AES.decrypt(name, keyname);
					
					session.setAttribute("uid", id);
					session.setAttribute("keyname", keyname);
					session.setAttribute("username", name);
					request.setAttribute("message", "Login Successfully");
				
						response.sendRedirect("Patient/index.jsp");
					
				}
				else
				{
					String sql1="Select * from doctor where user_username='"+username+"' and user_password='"+password+"'";
			        ResultSet rs1=db.getResultSet(sql1);
			        try {
							if(rs1.next())
							{
								//session.setAttribute("role", "teacher");
								String name=rs1.getString("user_name");
								String id=rs1.getString("user_id");
								String key=rs1.getString("user_key");
								
								String keyname1=AES.decrypt_use(key);
								name=AES.decrypt(name, keyname1);
								//name=AES.decrypt(name, keyname1);
								
								session.setAttribute("did", id);
								session.setAttribute("keyname", keyname1);
								session.setAttribute("username", name);
								request.setAttribute("message", "Login Successfully");
								response.sendRedirect("Doctor/index.jsp");
							}
							else
							{
								request.setAttribute("message", "Please provide proper username and password");
								response.sendRedirect("login.jsp");
							}
				        }
				        catch (SQLException e)
						{
							e.printStackTrace();
						}
				}
			} catch (SQLException e)
			{
				e.printStackTrace();
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
	}

}
