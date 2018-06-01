package com.java.servlet;

import java.io.IOException;
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

import SendSMS.SendSms;

import com.java.database.DatabaseConnection;

/**
 * Servlet implementation class diagnosis_add
 */
@WebServlet("/diagnosis_add")
public class diagnosis_add extends HttpServlet {
	private static final long serialVersionUID = 1L;
       
    /**
     * @see HttpServlet#HttpServlet()
     */
    public diagnosis_add() {
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
		String did=(String)session.getAttribute("did");
		String keyname=(String)session.getAttribute("keyname");
		String history_id = request.getParameter("history_id");
		String prescription = request.getParameter("prescription");
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
		String amt = request.getParameter("fee");
		String hospitalised = request.getParameter("hospitalised");
		String hospital_name = request.getParameter("hospital");
		String status = "P";
		
		try {
			prescription=AES.encrypt(prescription, keyname);
			history_date=AES.encrypt(history_date,keyname);
			amt=AES.encrypt(amt,keyname);
			hospitalised=AES.encrypt(hospitalised,keyname);
			hospital_name=AES.encrypt(hospital_name,keyname);
			//status=AES.encrypt(status,keyname);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
			
		DatabaseConnection db = new DatabaseConnection();
		db.dbconnection();
		
		String sql3="Select * from tbl_diagnosis where history_id='"+history_id+"'";
        ResultSet rs3=db.getResultSet(sql3);
	    try {
				if(!rs3.next())
				{
				
					String query = "INSERT INTO tbl_diagnosis(history_id,diagnosis,doctor_id,request_date,amt,hospitalised,hospital_name,status) VALUES" +
							"('"+history_id+"' , '"+prescription+"' , '"+did+"' , '"+history_date+"' , '"+amt+"' , '"+hospitalised+"' , '"+hospital_name+"', '"+status+"')";
					
						int i = db.getUpdate(query);
						if(i==1)
						{
							String mobile=(String)session.getAttribute("mobile");
							SendSms sms=new SendSms();
							sms.Way2SMS(mobile,  "Prescription for your disease is given by your doctor");
							request.setAttribute("message", "Disease Added Successfully");
							response.sendRedirect("Doctor/index.jsp");
						}
						else
						{
							request.setAttribute("message", "Warning : Please provide all fields");
							response.sendRedirect("Doctor/prescript_diagnosis.jsp?history_id="+history_id);
						}
				}
				else
				{
					String query = "UPDATE tbl_diagnosis SET diagnosis='"+prescription+"',request_date='"+history_date+"' where history_id='"+history_id+"'";
					
						int i = db.getUpdate(query);
						if(i==1)
						{
							String mobile=(String)session.getAttribute("mobile");
							SendSms sms=new SendSms();
							sms.Way2SMS(mobile,  "Your changed prescription for your disease is updated by the doctor");
							request.setAttribute("message", "Disease Added Successfully");
							response.sendRedirect("Doctor/viewpatient.jsp");
						}
						else
						{
							request.setAttribute("message", "Warning : Please provide all fields");
							response.sendRedirect("Doctor/viewpatient.jsp?history_id="+history_id);
						}
				}
		} 
	    catch (SQLException e) 
	    {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

}
