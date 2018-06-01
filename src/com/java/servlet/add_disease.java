package com.java.servlet;

import java.io.IOException;
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
 * Servlet implementation class add_disease
 */
@WebServlet("/add_disease")
public class add_disease extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public add_disease() {
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
		HttpSession session =request.getSession();
		String uid=(String)session.getAttribute("uid");
		String keyname=(String)session.getAttribute("keyname");
		String disease_name = request.getParameter("disname");
		String symptoms = request.getParameter("sym");
		String getid=request.getParameter("getid");
		String getspe = request.getParameter("spe");
		String spe="";
		if(getid==null)
		{
			spe =getspe;
		}
		else
		{
			spe =getid;
		}
		
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
            
            try {
				disease_name=AES.encrypt_use(disease_name);
				symptoms=AES.encrypt(symptoms,keyname);
				history_date=AES.encrypt(history_date,keyname);
				//spe=AES.encrypt(spe,keyname);
				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
            
		DatabaseConnection db = new DatabaseConnection();
		db.dbconnection();
		
		String query = "INSERT INTO tbl_history(user_id,doctor_id,disease_name,symptoms,history_date,total_amt) VALUES" +
				"('"+uid+"' , '"+spe+"' , '"+disease_name+"' , '"+symptoms+"' , '"+history_date+"' , '')";
		
			int i = db.getUpdate(query);
			if(i==1)
			{
				request.setAttribute("message", "Disease Added Successfully");
				response.sendRedirect("Patient/index.jsp");
			}
			else
			{
				request.setAttribute("message", "Warning : Please provide all fields");
				response.sendRedirect("Patient/disease_add.jsp");
			}

	}

}
