package com.java.servlet;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import AES.AES;

import com.java.database.DatabaseConnection;

/**
 * Servlet implementation class UpdateOwnerServlet
 */
@WebServlet("/UpdateAccountServlet")
public class UpdateAccountServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		HttpSession session =request.getSession();
		String keyname=(String)session.getAttribute("keyname");
		String id=(String)session.getAttribute("uid");
		String fullName = request.getParameter("name");
		String address = request.getParameter("address");
		String age = request.getParameter("age");
		String email = request.getParameter("email");
		String mobile = request.getParameter("mobile");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		
		try {
			fullName = AES.encrypt(fullName,keyname);
			address = AES.encrypt(address,keyname);
			age = AES.encrypt(age,keyname);
			email = AES.encrypt(email,keyname);
			mobile = AES.encrypt(mobile,keyname);
			username = AES.encrypt_use(username);
			password = AES.encrypt_use(password);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}

		
		DatabaseConnection db = new DatabaseConnection();
		db.dbconnection();
		
		String query = "UPDATE patient SET name='"+fullName+"' , Address='"+address
				+"' , Age='"+age+"' , Email='"+email+"' , mobile='"
				+mobile+"' , username='"+username+"' , password='"+password
				+"' WHERE user_id="+id;
		
		int i = db.getUpdate(query);
		
		if(i==1)
		{
			session.setAttribute("username", fullName);		
			response.sendRedirect("Patient/myProfile.jsp");
		}
		else
		{
			response.sendRedirect("Patient/profileEdit.jsp");
		}
	}

}
