<%@page import="com.java.database.DatabaseConnection" %>
<%@page import="java.sql.ResultSet"%>
<%@page import="AES.AES"%>
<%@page import="AES.AprioriFrequentSet"%>

<%
DatabaseConnection db = new DatabaseConnection();
db.dbconnection();
String doctorid="";
String user_name="";
String spename="";
	
String keyname=(String)session.getAttribute("keyname");
String disid=request.getParameter("did");
String disid1=AES.encrypt_use(disid);
//System.out.println(disid1);

String sql12 = "Select count(history_id) as getcount From tbl_history Where disease_name='"+disid1+"'";
ResultSet rs12 = db.getResultSet(sql12);
if(rs12.next()) 
{
	String getcount=rs12.getString("getcount");
	int getcount1=Integer.parseInt(getcount);
	
	if(getcount1<5)
	{
%>
<select name="spe" id="spe" tabindex="1" style="padding:8px 10px">
	<option value="">-----Select Specialist Name-----</option>
<%
		String sql1 = "Select * From spe where did='"+disid+"'";
		ResultSet rs1 = db.getResultSet(sql1);
		while (rs1.next()) 
		{
			spename=rs1.getString("speciality");
			String abb=rs1.getString("speabb");
			String did=rs1.getString("did");
			String speabb=rs1.getString("speabb");
	
					//speabb=AES.encrypt(spename,keyname);
	
					String sql2 = "Select * From doctor";
					System.out.println(sql2);
					ResultSet rs2 = db.getResultSet(sql2);
					while (rs2.next()) 
					{
						String user_key=rs2.getString("user_key");
						user_key=AES.decrypt_use(user_key);
						
						String spe=rs2.getString("spe");
						spe=AES.decrypt(spe, user_key);
						
					if(speabb.equalsIgnoreCase(spe))
					{
						user_name=rs2.getString("user_name");
						user_name=AES.decrypt(user_name,user_key);
						System.out.println(user_name);
						doctorid=rs2.getString("user_id");
%>
	<option value="<%=doctorid%>"><%=user_name %></option>
<%
					}
				}
		}
%>
</select>
<%
	}
	else
	{
		String maindata="0";
		int n=0;
		String ssql1 = "Select * From spe where did='"+disid+"'";
		ResultSet rss1 = db.getResultSet(ssql1);
		rss1.next();
		String means=rss1.getString("speabb");
		
		disid=AES.encrypt(disid,keyname);
		
			String sql1 = "Select * From doctor";
			ResultSet rs1 = db.getResultSet(sql1);
			while (rs1.next()) 
			{
				String getdoctor_id=rs1.getString("user_id");
				String user_key=rs1.getString("user_key");
				user_key=AES.decrypt_use(user_key);
				
				String spe=rs1.getString("spe");
				spe=AES.decrypt(spe, user_key);
				if(means.equalsIgnoreCase(spe))
				{
					//System.out.println(spe);
					//String query1 = "Select * From tbl_history Where doctor_id='"+getdoctor_id+"' and disease_name='"+disid+"'";
					//ResultSet res1 = db.getResultSet(query1);
					//while(res1.next()) 
					//{
						//String history_id=res1.getString("history_id");
						//System.out.println(history_id);
						
							String query2 = "Select * From tbl_diagnosis Where doctor_id='"+getdoctor_id+"'";
							ResultSet res2 = db.getResultSet(query2);
							while(res2.next()) 
							{
								String doctor_id=res2.getString("doctor_id");
								if(doctor_id!=null)
								{
									maindata=maindata+","+doctor_id;
								}
								else
								{
									maindata=maindata+","+getdoctor_id;
										System.out.println(maindata);
								}
								//System.out.println(maindata);
							}
							//else
							//{
								maindata=maindata+","+getdoctor_id;
								System.out.println(maindata);
							//}
					//}
				}
			}

		AprioriFrequentSet ap=new AprioriFrequentSet();
		String get=ap.getdata(maindata);
		double avg=0;
		double finalre=0;
		System.out.println(get);
		String[] divisions = get.split(",");
%>
		<div style="float:left;padding:10px 20px;font-size:18px;">
		<table class="tabledata">
			<tr>
				<th>Doctor Name</th>
				<th>Specialist In</th>
				<th>Total Patient</th>
				<th>Rating</th>
				<th>Select Your</th>
			</tr>
			<tr>
<%
		for(int i=0;i<divisions.length;i++)
		{
			String dgetid=divisions[i];
			String query3 = "Select * From doctor Where user_id='"+dgetid+"'";
			ResultSet res3 = db.getResultSet(query3);
			while(res3.next()) 
			{
				String didikey=res3.getString("user_key");
				didikey=AES.decrypt_use(didikey);
				String doctor_name=res3.getString("user_name");
				String spe=res3.getString("spe");
				doctor_name=AES.decrypt(doctor_name,didikey);
				spe=AES.decrypt(spe,didikey);
				
				String query4 = "Select * From spe Where speabb='"+spe+"'";
				ResultSet res4 = db.getResultSet(query4);
				if(res4.next()) 
				{
					String speciality=res4.getString("speciality");
					
					//int n=0;
					int total1=0;
					String query5 = "Select count(did) as total From rating Where did='"+dgetid+"'";
					ResultSet res5 = db.getResultSet(query5);
					if(res5.next()) 
					{
						String total=res5.getString("total");
						total1=Integer.parseInt(total);
						//avg=avg+data;
						//n++;
					}
					double totalsum1=0;
					String query6 = "Select sum(rating) as totalsum From rating Where did='"+dgetid+"'";
					System.out.println(query6);
					ResultSet res6 = db.getResultSet(query6);
					while(res6.next()) 
					{
						String totalsum=res6.getString("totalsum");
						if(totalsum!=null)
						{
							totalsum1=Double.parseDouble(totalsum);
							System.out.println("total sum"+totalsum1);
							finalre=((double)(totalsum1)/total1);
						}
						else
						{
							finalre=0;
						}
					}
%>
				<td>
					<div style="padding:10px 0;"><%=doctor_name%></div>
				</td>
				<td>
					<div style="padding:10px 0;"><%=speciality%></div>
				</td>
				<td>
					<div style="padding:10px 0;"><%=total1%></div>
				</td>
				<td>
					<div style="padding:10px 0;"><%=finalre%></div>
				</td>
				<td>
					<div style="padding:10px 0;"><input type="radio" name="getid" value="<%=dgetid%>"/></div>
				</td>
			</tr>
<%
				}
			}
			n++;
		}
%>
			</table>
		</div>
<%
	}
}

%>