package com.java.servlet;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.Calendar;
import java.util.GregorianCalendar;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import AES.AES;

import com.java.database.DatabaseConnection;

/**
 * Servlet implementation class diagnosis_add
 */
@WebServlet("/addhistory")
public class addhistory extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public addhistory() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		PrintWriter out = response.getWriter();
		HttpSession session =request.getSession();
		String keyname=(String)session.getAttribute("keyname");
		String history_id = request.getParameter("history_id");
		System.out.println(history_id);

		String months[] = {
                "Jan", "Feb", "Mar", "Apr",
                "May", "Jun", "Jul", "Aug",
                "Sep", "Oct", "Nov", "Dec"};

            GregorianCalendar gcalendar = new GregorianCalendar();
            String date = (gcalendar.get(Calendar.DATE) + " ");
            String month = ((months[gcalendar.get(Calendar.MONTH)]) + " ");
            String year = (gcalendar.get(Calendar.YEAR) + " ");
            String hour = (gcalendar.get(Calendar.HOUR) + ":");
            String minute = (gcalendar.get(Calendar.MINUTE) + ":");
            String second = (gcalendar.get(Calendar.SECOND) + "");

        String history_date = date + month + year + hour + minute + second;
        String accept="A";
		
		try {

			//history_date=AES.encrypt(history_date,keyname);
			
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
			
		DatabaseConnection db = new DatabaseConnection();
		db.dbconnection();

					String query = "Update tbl_diagnosis Set status='"+accept+"', accdate='"+history_date+"' Where history_id='"+history_id+"'";
					
						int i = db.getUpdate(query);
						if(i==1)
						{
							session.setAttribute("history_id", history_id);
							request.setAttribute("message", "Disease Added Successfully");
							response.sendRedirect("Patient/rating.jsp");
						}
						else
						{
							request.setAttribute("message", "Warning : Please provide all fields");
							response.sendRedirect("Patient/viewpre.jsp");
						}

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		
	}

}
