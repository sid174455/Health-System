<%@page import="com.java.database.DatabaseConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="AES.AES"%>
<%@include file="header.jsp" %>


		
<script type="text/javascript" language="JavaScript">
  
function init()
{
	document.getElementById('name').focus();
}  
window.onload = init;

function validate()
{
	var valid = false;
	var name = trim(document.getElementById('name').value);
	var address = trim(document.getElementById('address').value);
	var qualification = trim(document.getElementById('qualification').value);
	var mobile = trim(document.getElementById('mobile').value);
	var username = trim(document.getElementById('username').value);
	var password = trim(document.getElementById('password').value);
	var confirmpassword = trim(document.getElementById('confirmpassword').value);
	if(name == "" )
	{
		alert("Required - Please provide Full Name");
		document.getElementById("name").focus();
	}
	else if(address == "" )
	{
		alert("Required - Please provide Address");
		document.getElementById("address").focus();
	}
	else if((mobile == "") || (!(/^\d{10}$/.test(mobile))))
	{
		alert("Required - Please Provide valid 10 digit Mobile No");
		document.getElementById("mobile").value = "";
			document.getElementById("mobile").focus();
	}
	else if(qualification == "" )
	{
		alert("Required - Please provide Qualification");
		document.getElementById("qualification").value = "";
		document.getElementById("qualification").focus();
	}
	else if(username == "" )
	{
		alert("Required - Please provide Username");
		document.getElementById("username").focus();
	}
	else if(password == "" )
	{
		alert("Required - Please provide Password");
		document.getElementById("password").focus();
	}
	else if((confirmpassword == "" ) || (confirmpassword != password))
	{
		alert("Required - Please provide Matching Password");
		document.getElementById("confirmpassword").value = "";
		document.getElementById("confirmpassword").focus();
	}
	else
	{
		valid = true;
	}
	return valid;
} 

</script>    

		<%

			if(request.getSession().getAttribute("message")!=null)
			{
		%>
		<script type="text/javascript" language="JavaScript">
  			alert("<%=request.getSession().getAttribute("message") %>");
		</script>
		<% 
		request.getSession().setAttribute("message", null);
			} %>


		<table width="100%" cellpadding="0" cellspacing="10">
			<tr style="vertical-align:top">
				<td width="100px" >
					<table width="100%" class="box_content2" cellpadding="0" cellspacing="5">
						<tr>
							<td >
								<img width="150px" style="margin:10px -10px 10px 10px;border:1px solid #89D7FD" src="../images/user.png"  />
							</td>
						</tr>
					</table>
				</td>
				<td>
					<div class="box_content1">
						<div class="box_title">
							<div class="title_icon"><img src="../images/my_profile.png" width="50px" alt="" title="" /></div>
							<h2 style="margin-top:10px">Update <span class="dark_blue">Profile Details</span></h2>
						</div>
                    
						<div class="box_text_content">
							<form name="registerForm"  onsubmit="return validate();" method="post" action="../UpdateAccountServlet" >
								<table width="90%" style="padding-top:10px;border:1px solid #116c64; border-radius:16px;">
							
							<%
								String id=(String)session.getAttribute("uid");
								String keyname=(String)session.getAttribute("keyname");
								DatabaseConnection db = new DatabaseConnection();
								db.dbconnection();
								
								String sql="Select * from patient where user_id='"+id+"'";
								ResultSet rs=db.getResultSet(sql);
								rs.next();
								
							%>	
									<tr>
										<td  width="180px" style="padding-left:50px"><h1><span class="dark_blue">Full Name *</span></h1></td>
										<td ><input autocomplete="off" value="<%=AES.decrypt(rs.getString("name"),keyname) %>" tabindex="1" type="text"  id="name" name="name" class="text" /></td>
									</tr>
									<tr>
										<td   style="padding-left:50px;vertical-align:top"><h1><span class="dark_blue">Address *</span></h1></td>
										<td><textarea rows="5" tabindex="2"   id="address" name="address" class="text" /><%=AES.decrypt(rs.getString("address"),keyname) %></textarea></td>
									</tr>
						
									<tr>
										<td   style="padding-left:50px"><h1><span class="dark_blue">Age *</span></h1></td>
										<td><input autocomplete="off" tabindex="4" type="text" value="<%=AES.decrypt(rs.getString("age"),keyname) %>" id="age" name="age" class="text" style="width:30px" /> yrs</td>
									</tr>
									<tr>
										<td   style="padding-left:50px"><h1><span class="dark_blue">Email ID</span></h1></td>
										<td><input autocomplete="off" tabindex="5" type="text" value="<%=AES.decrypt(rs.getString("email"),keyname) %>" onblur="chkEmail()"  id="email" name="email" class="text"  style="width:50%" /></td>
									</tr>
									<tr>
										<td   style="padding-left:50px"><h1><span class="dark_blue">Mobile No *</span></h1></td>
										<td><input autocomplete="off" tabindex="6" type="text"  value="<%=AES.decrypt(rs.getString("mobile"),keyname) %>" id="mobile" name="mobile" class="text"  style="width:50%" /></td>
									</tr>									
									<tr>
										<td   style="padding-left:50px"><h1><span class="dark_blue">Username *</span></h1></td>
										<td><input autocomplete="off" tabindex="8" type="text" value="<%=AES.decrypt_use(rs.getString("username")) %>"  id="username" name="username" class="text"  style="width:50%" /></td>
									</tr>
									<tr>
										<td   style="padding-left:50px"><h1><span class="dark_blue">Password *</span></h1></td>
										<td><input autocomplete="off" tabindex="9" type="password"  value="<%=AES.decrypt_use(rs.getString("password")) %>" id="password" name="password" class="text"  style="width:50%" /></td>
									</tr>
									<tr>
										<td   style="padding-left:50px"><h1><span class="dark_blue">Confirm Password *</span></h1></td>
										<td><input autocomplete="off" tabindex="10" type="password"  id="confirmpassword" name="confirmpassword" class="text"  style="width:50%" /></td>
									</tr>
									<tr height="50px">
										<td></td>
										<td><input type="submit"  value="Update Now"  tabindex="11" class="button" id="submit" name="submit">
										<input type="button"  onclick="loadPage('index.jsp');" value="Back to Home"  tabindex="12" class="button" id="cancel" name="cancel">
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