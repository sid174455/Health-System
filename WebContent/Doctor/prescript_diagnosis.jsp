<%@page import="com.java.database.DatabaseConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="AES.AES"%>

<%
	request.getSession().setAttribute("selectPage",1);
%>



<%@include file="header.jsp" %>
   
<script type="text/javascript" language="JavaScript">
  
function init()
{
	//document.getElementById('name').focus();
}  
window.onload = init;

function validate()
{
	var valid = false;
	var prescription = trim(document.getElementById('prescription').value);
	var hospital1 = trim(document.getElementById('hospital1').value);
	var hospital2 = trim(document.getElementById('hospital2').value);
	var fee = trim(document.getElementById('fee').value);
	if(prescription == "" )
	{
		alert("Required - Please provide Diagnosis Prescription");
		document.getElementById("prescription").focus();
	}
	else if((fee == "" ) || ((isNaN(fee)) || (fee.indexOf(" ")!=-1) || (fee <= 0))) 
	{
		alert("Required - Please provide valid Fees Amount");
		document.getElementById("fee").value = "";
		document.getElementById("fee").focus();
	}
	else if((hospitalised == "YES") && (hospital1 == "") && (hospital2 == ""))
	{
		alert("Required - Please provide Hospital");
	}
	else
	{
		valid = true;
	}
	return valid;
} 
var hospitalised = "";
function showTD(chk_value, str)
{
	if(str == "YES")
	{
		if(chk_value)
		{
			document.getElementById('td_hospitalised').style.display='';
		}
	}
	else
	{
		if(chk_value)
		{
			document.getElementById('td_hospitalised').style.display='none';
		}
	}
	hospitalised = str;
	//alert(hospitalised);
}

</script>    
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
					</table>
				</td>
				<td>
					<div class="box_content1">
						<div class="box_title">
							<div class="title_icon"><img src="../images/mini_icon1.gif" alt="" title="" /></div>
							<h2>New <span class="dark_blue">Prescription</span></h2>
						</div>
                    
						<div class="box_text_content">
							<form name="send_form"  onsubmit="return validate();" method="post" action="../diagnosis_add" >
							<table width="90%" style="padding-top:10px;border:1px solid #116c64; border-radius:16px;">
							<tr >
							<td>
							<table width="100%"  cellpadding="0" cellspacing="0">
					<%
						String history_id=request.getParameter("history_id");
						String keyname=(String)session.getAttribute("keyname");
						DatabaseConnection db = new DatabaseConnection();
						db.dbconnection();
						
						String sql1="Select * from tbl_history where history_id='"+history_id+"'";
				        ResultSet rs1=db.getResultSet(sql1);
				       
				        if(rs1.next())
						{
				        	
				        	String sql="Select * from tbl_history where history_id='"+history_id+"'";
					        ResultSet rs=db.getResultSet(sql);
					        while(rs.next())
					        {
					        	String history_id1 = rs.getString("history_id");
					        	String user_id = rs.getString("user_id");
					        	String history_date = rs.getString("history_date");
					        	String disease_name = rs.getString("disease_name");
					        	String symptoms = rs.getString("symptoms");
					        	
					        	String ssql1="Select * from patient where user_id='"+user_id+"'";
								ResultSet rss1=db.getResultSet(ssql1);
								rss1.next();
								String uidkey=rss1.getString("key1");
								uidkey=AES.decrypt_use(uidkey);
								System.out.println(uidkey);

					        	
					        	history_date=AES.decrypt(history_date,uidkey);
					        	disease_name=AES.decrypt_use(disease_name);
					        	symptoms=AES.decrypt(symptoms,uidkey);
					        	
					        	String sql4="Select * from dis Where id='"+disease_name+"'";
						        ResultSet rs4=db.getResultSet(sql4);
					        	rs4.next();
					        	String disname=rs4.getString("diseases");
					        	
					        	String sql5="Select * from sym Where id='"+symptoms+"'";
						        ResultSet rs5=db.getResultSet(sql5);
					        	rs5.next();
					        	String symname=rs5.getString("sym");
					        	
					        	String user_name="";
					        	String sql2="Select * from patient where user_id='"+user_id+"'";
						        ResultSet rs2=db.getResultSet(sql2);
						        while(rs2.next())
						        {
						        	user_name = rs2.getString("name");
						        	user_name=AES.decrypt(user_name,uidkey);

					%>
							<tr>
								<td  width="150px" style="padding-left:20px"><h1><span class="dark_blue">Patient Name </span></h1></td>
								<td ><%=user_name %><input type="hidden" value="<%=history_id1 %>" name="history_id"></td>
							</tr>
							<tr>
								<td  width="150px" style="padding-left:20px"><h1><span class="dark_blue">Disease Name </span></h1></td>
								<td ><%=disname %></td>
							</tr>
							<tr>
								<td  width="150px" style="padding-left:20px"><h1><span class="dark_blue">Symptoms</span></h1></td>
								<td ><%=symname %></td>
							</tr>
							<tr>
								<td  width="150px"  style="padding-left:20px;vertical-align:top"><h1><span class="dark_blue">Your Prescription *</span></h1></td>
								<td><textarea rows="5" tabindex="2"   id="prescription" name="prescription" class="text" /></textarea></td>
							</tr>
							<tr>
								<td  width="150px" style="padding-left:20px"><h1><span class="dark_blue">Hospitalisation </span></h1></td>
								<td ><input tabindex="1" type="radio" onchange="showTD(this.value, 'YES')"  name="hospitalised" value="YES" class="" />Yes&nbsp;&nbsp;
								<input tabindex="1" type="radio" onchange="showTD(this.value, 'NO')"   name="hospitalised" checked value="NO" class="" />No
								</td>
							</tr>
							</table>
							</td>
							</tr>
							<tr >
							<td>
							<table width="100%" cellpadding="0" cellspacing="0">
							<tr id="td_hospitalised" style="display:none">
								<td  width="150px" style="padding-left:20px"><h1><span class="dark_blue">Select Hospital </span></h1></td>
								<td  >
									<table >
										<tr>
											<td>
												<select  id="hospital" name="hospital" class="text" style="width:300px">
												<option value=""> -- Select Hospital -- </option>
												<option value="Gandhi Hospital Panvel"> Gandhi Hospital Panvel </option>
												<option value="Gandhi Hospital Kolad"> Gandhi Hospital Kolad </option>
												<option value="ABC Hospital Panvel"> ABC Hospital Panvel </option>
												</select>
											</td>
										</tr>
									</table>								
								</td>
							</tr>					
							</table>
							</td>
							</tr>
							<tr >
							<td>
							<table width="100%" cellpadding="0" cellspacing="0">
							
							<tr>
								<td  width="150px" style="padding-left:20px"><h1><span class="dark_blue">Your Fee </span></h1></td>
								<td ><input tabindex="1" type="text"  id="fee" name="fee" style="width:100px" class="text" /></td>
							</tr>
							</table>
							</td>
							</tr>
							<tr >
				<%
						        }
						    }
					        		
						}
				%>	
							<td>
							<table width="100%" cellpadding="0" cellspacing="0">
							<tr >
								<td  width="150px" style="padding-left:20px"></td>
								<td><input type="submit"  value="Prescribe Now"  tabindex="11" class="button" id="submit" name="submit">
								<input type="button"  onclick="loadPage('index.jsp');" value="Back"  tabindex="12" class="button" id="cancel" name="cancel">
								</td>
							</tr>
							</table>
							</td>
							</tr>
							</table>
							</form>
		
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