<%@page import="com.java.database.DatabaseConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="AES.AES"%>

<%
	request.getSession().setAttribute("selectPage",1);
%>



<%@include file="header.jsp" %>

<script type="text/javascript" src="../js/jquery.min.js"></script>
<script src="../js/jquery-1.9.1.js"></script>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7.1/jquery.min.js"></script>

<script type="text/javascript">

function access( pass ) {
	
	var table = document.getElementById("innerDetails");
	var cells = table.getElementsByTagName("td");
	
	var val = (pass * 5);
	
	var fileId = document.getElementById("fileId"+pass).value;
	var username = cells[val+1].innerText;
	username =  username.trim();
	
	//alert(fileId+'  '+username+'name');
	
	$.ajax({
		type: "POST",
		url: "ProvideAccessServlet",
		data: 'fileid='+ fileId+'&username='+username+'&type=access',
		success: function(html){
			//alert("get : "+html);
			loadPage('index.jsp');
			//deleteRow(pass);
		
		}
	});	
}


function cancel( pass ) {
	
	var table = document.getElementById("innerDetails");
	var cells = table.getElementsByTagName("td");
	
	var val = (pass * 5);
	
	var fileId = document.getElementById("fileId"+pass).value;
	var username = cells[val+1].innerText;
	username =  username.trim();
	
	//alert(fileId+'  '+username+'name');
	
	$.ajax({
		type: "POST",
		url: "ProvideAccessServlet",
		data: 'fileid='+ fileId+'&username='+username+'&type=cancel',
		success: function(html){
			//alert("get : "+html);
			loadPage('index.jsp');
			//deleteRow(pass);
		
		}
	});	
}



function deleteRow(value) {
    
    var table = document.getElementById('innerDetails');
    var rowCount = table.rows.length;
    table.deleteRow(value);
    
    for(var i=1; i<rowCount; i++) {
    	if(i>3)
    		{
    			if(i!=(rowCount-1))
    				{
    					table.deleteRow(i);
    					rowCount--;
                        i--;
    				}
    		}
            
    }
    
}


</script>


<table width="100%" cellpadding="0" cellspacing="10">
	<tr style="vertical-align:top">
		<td width="100px" >
			<table width="100%" class="box_content2" cellpadding="0" cellspacing="5">
				<tr>
					<td >
						<img width="150px" style="margin:10px -10px 10px 10px;border:1px solid #89D7FD" src="../images/Owner.png"  />
					</td>
				</tr>
			</table>
		</td>
		
		<td>
			<div class="box_content1">
				<div class="box_title">
					<div class="title_icon"><img src="../images/mini_icon1.gif" alt="" title="" /></div>
					<h2>New <span class="dark_blue">Patient Details</span></h2>
				</div>
				
				<div class="box_text_content" >
				<table id="innerDetails" width="100%" cellpadding="0" cellspacing="5">
					
					<tr align="center">
					<td width="10px" ><h1><span class="dark_blue">Sr No</span></h1></td>
						<td width="100px"><h1><span class="dark_blue">Requested Patient Name</span></h1></td>
						<td width="100px" ><h1><span class="dark_blue">Disease Name</span></h1></td>
						<td width="100px" ><h1><span class="dark_blue">Date</span></h1></td>
						
						<td width="90px" ><h1><span class="dark_blue">View Details</span></h1></td>
						<td width="90px" ><h1><span class="dark_blue"></span></h1></td>
									
					</tr>
					
					<%
						String did=(String) session.getAttribute("did");
						String keyname=(String)session.getAttribute("keyname");

						DatabaseConnection db = new DatabaseConnection();
						db.dbconnection();
						
						String sql1="Select * from tbl_history Where doctor_id='"+did+"'";
				        ResultSet rs1=db.getResultSet(sql1);
				       
				        if(rs1.next())
						{
				        	int i=1;
				        	String sql="Select * from tbl_history Where doctor_id='"+did+"'";
					        ResultSet rs=db.getResultSet(sql);
					        while(rs.next())
					        {
					        	String history_id = rs.getString("history_id");
					        	String user_id = rs.getString("user_id");
					        	String history_date = rs.getString("history_date");
					        	String disease_name = rs.getString("disease_name");
					        	String symptoms = rs.getString("symptoms");
					        	String doctor_id = rs.getString("doctor_id");
					        	
					        	String ssql2="Select * from patient where user_id='"+user_id+"'";
						        ResultSet srs2=db.getResultSet(ssql2);
						        while(srs2.next())
						        {
						        	String key1 = srs2.getString("key1");
						        	key1=AES.decrypt_use(key1);
						        	history_date=AES.decrypt(history_date,key1);
						        	disease_name=AES.decrypt_use(disease_name);
						        	symptoms=AES.decrypt(symptoms,key1);
						        }

					        	String sql4="Select * from dis Where id='"+disease_name+"'";
						        ResultSet rs4=db.getResultSet(sql4);
					        	rs4.next();
					        	String disname=rs4.getString("diseases");
						        
					        	String sql3="Select * from tbl_diagnosis where history_id='"+history_id+"'";
						        ResultSet rs3=db.getResultSet(sql3);
					        if(!rs3.next())
					        {
					        	String user_name="";
					        	String mobile="";
					        	String sql2="Select * from patient where user_id='"+user_id+"'";
						        ResultSet rs2=db.getResultSet(sql2);
						        while(rs2.next())
						        {
						        	String key1 = rs2.getString("key1");
						        	key1=AES.decrypt_use(key1);
						        	
						        	user_name = rs2.getString("name");
						        	user_name=AES.decrypt(user_name,key1);
						        	mobile = rs2.getString("mobile");
						        	mobile=AES.decrypt(mobile,key1);
						        	session.setAttribute("mobile", mobile);
						        

					%>
					<tr align="center">
						<td><h4><span class="dark_blue"><%=i %></span></h4></td>
						<td><h4><span class="dark_blue"><%=user_name %></span></h4></td>
						<td><h4><span class="dark_blue"><%=disname %></span></h4> </td>
						<td><h4><span class="dark_blue"><%=history_date %></span></h4></td>
						
						<td><h4><span class="dark_blue">
						<a href="prescript_diagnosis.jsp?history_id=<%=history_id %>"><input type="button" value="Give Prescription" class="button" /></a>
						<input type="hidden"  id="fileId" name="fileId" value="" />
						</span></h4> </td>
						<td><h4><span class="dark_blue">
						<input type="button" value="Cancel" onClick="cancel();" class="button" />
						</span></h4> </td>			
					</tr>
					
				<%
						        }
					        }
						    }
					        		i++;
						}
						else
						{
				%>	
					
						<tr>
							<td width="20px" ><img src="../images/calendar.gif" alt="" title="" class="box_icon" />
							<span style="position:absolute;margin-top:10px;margin-left:-27px"></span></td>
							<td style="font-size:16px;color:red"><u><i>No Patient Details available yet!</i></u></td>
						</tr>
				<%
						}
				%>
					</table>
				</div>
				
				
			</div>
		</td>
		
		
		
	</tr>
</table>

<%@include file="footer.jsp" %>