<%@page import="com.java.database.DatabaseConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="AES.AES"%>
<%@include file="header.jsp" %>	
		<%
			if(request.getAttribute("message")!=null)
			{
		%>
		<script type="text/javascript" language="JavaScript">
  			alert("<%=request.getAttribute("message") %>")
		</script>
		<%} %>
       
    <div id="main_content">
		<table width="100%" cellpadding="0" cellspacing="10">
			<tr style="vertical-align:top">
				<td width="100px" >
					<table width="100%" class="box_content2" cellpadding="0" cellspacing="5">
						<tr>
							<td >
								<img width="150px" style="margin:10px -10px 10px 10px;border:1px solid #89D7FD" src="../images/disease.jpg"  />
							</td>
						</tr>
						<tr>
							<td>
								<a href="index.jsp" class="side_link active">Current Disease</a>
							</td>
						</tr>
						<tr>
							<td>
								<a href="disease_add.jsp" class="side_link">Add New Disease</a>
							</td>
						</tr>
					</table>
				</td>
				<td>
					<div class="box_content1">
						<div class="box_title">
							<div class="title_icon"><img src="../images/mini_icon1.gif" alt="" title="" /></div>
							<h2>My <span class="dark_blue">Current Diseases</span></h2>
						</div>
                    
						<div class="box_text_content" >
							<table width="100%" cellpadding="0" cellspacing="5" >
							
							<%
								String uid=(String) session.getAttribute("uid");
								String keyname=(String)session.getAttribute("keyname");
								DatabaseConnection db = new DatabaseConnection();
								db.dbconnection();
								
								String sql1="Select * from tbl_history where user_id='"+uid+"'";
						        ResultSet rs1=db.getResultSet(sql1);
						       
						        if(rs1.next())
								{
						        	String sql="Select * from tbl_history where user_id='"+uid+"'";
							        ResultSet rs=db.getResultSet(sql);
							        while(rs.next())
							        {
							        	String history_id = rs.getString("history_id");
							        	String history_date = rs.getString("history_date");
							        	String disease_name = rs.getString("disease_name");
							        	String symptoms = rs.getString("symptoms");
							        	
							        	history_date=AES.decrypt(history_date,keyname);
							        	disease_name=AES.decrypt_use(disease_name);
							        	symptoms=AES.decrypt(symptoms,keyname);

							%>
									<tr>
										<td width="10px"><img src="../images/calendar.gif" alt="" title="" class="box_icon" /><span style="position:absolute;margin-top:10px;margin-left:-27px"></span></td>
										<td>
											<b><%=history_date %></b>
											<b><%=disease_name %></b> 
											(<%=symptoms %>)
										</td>
										<td width="150px">
											<!-- <a href="remove?id=<%=history_id %>" class="details">View Specialist</a>-->
										</td>
									</tr>
							<%

						        	}
								}
						        else
						        {
							%>		
								<tr>
									<td width="20px" ><img src="../images/calendar.gif" alt="" title="" class="box_icon" /><span style="position:absolute;margin-top:10px;margin-left:-27px"></span></td>
									<td style="font-size:16px;color:red"><u><i>No disease details added yet !</i></u></td>
								</tr>
							<%
								}
							%>			
							</table>
		
						</div>
						<div class="clear"></div> 				
	   
					</div>  
				</td>
			</tr>
		</table>

		<%@include file="footer.jsp" %>
			

</div>
</body>
</html>