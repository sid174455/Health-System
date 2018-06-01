package com.java.servlet;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.java.database.DatabaseConnection;

/**
 * Servlet implementation class saverate
 */
@WebServlet("/saverate")
public class saverate extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public saverate() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		HttpSession session =request.getSession();

		String rating = request.getParameter("rating");
		String did = request.getParameter("did");
		
		DatabaseConnection db = new DatabaseConnection();
		db.dbconnection();
		if(rating==null)
		{	
			   out.println("<script type=\"text/javascript\">");  
	    	   out.println("alert('Please Give Rating for Doctor Service');"); 
	    	   out.println("location=\"Patient/viewpre.jsp\";");
	    	   out.println("</script>");
		}
		else
		{
			String query1 = "Insert Into rating(did,rating) values('"+did+"','"+rating+"')";
			
			int i1 = db.getUpdate(query1);
			if(i1==1)
			{
				   out.println("<script type=\"text/javascript\">");  
		    	   out.println("alert('Thanks for Rating');"); 
		    	   out.println("location=\"Patient/viewpre.jsp\";");
		    	   out.println("</script>");
			}
			else
			{
				   out.println("<script type=\"text/javascript\">");  
		    	   out.println("alert('Please Give Rating for Doctor Service');");
		    	   out.println("location=\"Patient/rating.jsp\";");
		    	   out.println("</script>");
				   response.sendRedirect("Patient/viewpre.jsp");
			}
		}
	}

}
