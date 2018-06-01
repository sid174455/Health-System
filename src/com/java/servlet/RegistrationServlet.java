package com.java.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.security.SecureRandom;
import java.util.Random;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import AES.AES;

import com.java.database.DatabaseConnection;

/**
 * Servlet implementation class RegistrationServlet
 */
@WebServlet("/RegistrationServlet")
public class RegistrationServlet extends HttpServlet {
	private static final long serialVersionUID = 1L;
	String ownkey="mynewkeyispleasemakesureproperkey";

	
	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out =response.getWriter();
		String fullName = request.getParameter("name");
		String address = request.getParameter("address");
		String role = request.getParameter("role");
		String gender = request.getParameter("gender");
		String age = request.getParameter("age");
		String email = request.getParameter("email");
		String mobile = request.getParameter("mobile");
		String username = request.getParameter("username");
		String password = request.getParameter("password");
		String quali = request.getParameter("quali");
		String spe = request.getParameter("spe");
		String key=generateOtp();
		
		DatabaseConnection db = new DatabaseConnection();
		db.dbconnection();

			if(role.equalsIgnoreCase("doctor"))
			{	

				try {
					fullName = AES.encrypt(fullName, key);
					address = AES.encrypt(address, key);
					role = AES.encrypt(role, key);
					gender = AES.encrypt(gender, key);
					age = AES.encrypt(age,key);
					email = AES.encrypt(email, key);
					mobile = AES.encrypt(mobile, key);
					quali = AES.encrypt(quali, key);
					spe = AES.encrypt(spe, key);
					key = AES.encrypt_use(key);
					username = AES.encrypt_use(username);
					password = AES.encrypt_use(password);
					
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				String query = "INSERT INTO doctor(user_name,user_address,user_gender,user_age,user_qualification,spe,user_email,user_mobile,user_username,user_password,user_role,user_key) VALUES('"+fullName+"' , '"+address
						+"' , '"+gender+"' , '"+age+"' , '"+quali+"' , '"+spe+"' , '"+email+"' , '"+mobile+"' , '"
						+username+"' , '"+password+"', '"+role+"' , '"+key+"')";
				
				int i = db.getUpdate(query);
				if(i==1)
				{
					   out.println("<script type=\"text/javascript\">");  
			    	   out.println("alert('Registration Successfully Done');"); 
			    	   out.println("location=\"login.jsp\";");
			    	   out.println("</script>");
				}
				else
				{
					   out.println("<script type=\"text/javascript\">");  
			    	   out.println("alert('Warning : Please provide all fields');"); 
			    	   out.println("location=\"doctorsignup.jsp\";");
			    	   out.println("</script>");
				}
			}
			else
			{
				try {
					fullName = AES.encrypt(fullName, key);
					address = AES.encrypt(address, key);
					role = AES.encrypt(role, key);
					gender = AES.encrypt(gender, key);
					age = AES.encrypt(age,key);
					email = AES.encrypt(email, key);
					mobile = AES.encrypt(mobile, key);
					key = AES.encrypt_use(key);
					username = AES.encrypt_use(username);
					password = AES.encrypt_use(password);
					
				} catch (Exception e) {
					e.printStackTrace();
				}
				
				String query = "INSERT INTO patient(name,address,gender,age,email,mobile,username,password,role,key1) VALUES('"+fullName+"' , '"+address
						+"' , '"+gender+"' , '"+age+"' , '"+email+"' , '"+mobile+"' , '"
						+username+"' , '"+password+"', '"+role+"' , '"+key+"')";
				
				int i = db.getUpdate(query);
				if(i==1)
				{
					   out.println("<script type=\"text/javascript\">");  
			    	   out.println("alert('Registration Successfully Done');"); 
			    	   out.println("location=\"login.jsp\";");
			    	   out.println("</script>");
				}
				else
				{
					   out.println("<script type=\"text/javascript\">");  
			    	   out.println("alert('Warning : Please provide all fields');"); 
			    	   out.println("location=\"signup.jsp\";");
			    	   out.println("</script>");
				}
			}
	}
	public static String generateOtp()
	  {
	      Random RANDOM = new SecureRandom();
	      String letters = "ABCDEFGHJKMNPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789";

	      String pw = "";
	      for (int i=0; i<16; i++)
	      {
	          int index = (int)(RANDOM.nextDouble()*letters.length());
	          pw += letters.substring(index, index+1);
	      }
	      return pw;              
	  }

}
