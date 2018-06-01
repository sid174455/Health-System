
<%
	request.getSession().setAttribute("selectPage",6);
%>
<%@page import="com.java.database.DatabaseConnection" %>
<%@page import="java.sql.ResultSet"%>
<%@include file="header_home.jsp" %>

<script type="text/javascript" language="JavaScript">
  
function init()
{
	document.getElementById('name').focus();
}  
window.onload = init;
function validate()
{
	var valid = false;
	var age = trim(document.getElementById('age').value);
	var password = trim(document.getElementById('password').value);
	var confirmpassword = trim(document.getElementById('confirmpassword').value);

	if((age == "" ) || (isNaN(age)) || (age.indexOf(" ")!=-1) || (age <= 0)) 
	{
		alert("Required - Please provide valid Age");
		document.getElementById("age").value = "";
		document.getElementById("age").focus();
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


<table border="0" style="padding:50px" width="90%" cellspacing="10">
		<tr><td></td><td ><h1><span class="dark_blue"> Sign Up Panel</span></h1></td></tr>
		<tr valign="top"><td><img src="images/patient.png" width="150px" height="150px" class="img" style="padding:10px;border-radius:none" /></td>
		<td style="border:1px solid #116c64; border-radius:16px;width:100%">
		<form name="registerForm"  onsubmit="return validate();" method="post" action="RegistrationServlet" >
		<table width="100%" style="padding-top:10px">
		
		<tr>
			<td  width="180px" style="padding-left:50px"><h1><span class="dark_blue">Full Name *</span></h1></td>
			<td ><input tabindex="1"  type="text"  id="name" name="name" class="text" required/></td>
		</tr>
		<tr>
			<td   style="padding-left:50px;vertical-align:top"><h1><span class="dark_blue">Address *</span></h1></td>
			<td><textarea rows="5" tabindex="2"   id="address" name="address" class="text" required /></textarea></td>
		</tr>
		<tr>
			<td   style="padding-left:50px;vertical-align:top"><h1><span class="dark_blue">Qualification *</span></h1></td>
			<td><input  tabindex="3"  type="text"  id="quali" name="quali" class="text" required/>
			<input  tabindex="3"  type="hidden"  id="role" name="role" class="text" value="doctor"/></td>
		</tr>
		<tr>
			<td   style="padding-left:50px;vertical-align:top"><h1><span class="dark_blue">Specialist In*</span></h1></td>
			<td>
			<select name="spe" id="spe" tabindex="4">
			<option value="">-Select speciality -</option>
			<% 
				DatabaseConnection db = new DatabaseConnection();
				db.dbconnection();
				
				String sql="Select * From spe";
				ResultSet rs=db.getResultSet(sql);
				while(rs.next())
				{
					String spename=rs.getString("speciality");
					String abb=rs.getString("speabb");
			%>
				<option value="<%=abb%>"><%=spename %></option>
			<% 
				}
			%>
			</select>
			</td>
		</tr>
		<tr>
			<td   style="padding-left:50px"><h1><span class="dark_blue">Gender</span></h1></td>
			<td><input  type="radio" checked name="gender" class="" value="Male"/> Male <input  type="radio" name="gender" class="" value="Female" /> Female</td>
		</tr>
		<tr>
			<td style="padding-left:50px"><h1><span class="dark_blue">Age *</span></h1></td>
			<td><input  tabindex="5" type="text"  id="age" name="age" class="text" style="width:30px" required/> yrs</td>
		</tr>
		<tr>
			<td   style="padding-left:50px"><h1><span class="dark_blue">Email ID *</span></h1></td>
			<td><input  tabindex="6" type="email"  id="email" name="email" class="text"  style="width:50%" required/></td>
		</tr>
		<tr>
			<td   style="padding-left:50px"><h1><span class="dark_blue">Mobile No *</span></h1></td>
			<td><input  tabindex="7" type="text"  id="mobile" name="mobile" class="text"  style="width:50%" required/></td>
		</tr>
		<tr>
			<td   style="padding-left:50px"><h1><span class="dark_blue">Username *</span></h1></td>
			<td><input  tabindex="8" type="text"  id="username" name="username" class="text"  style="width:50%" required/></td>
		</tr>
		<tr>
			<td   style="padding-left:50px"><h1><span class="dark_blue">Password *</span></h1></td>
			<td><input  tabindex="9" type="password"  id="password" name="password" class="text"  style="width:50%" required/></td>
		</tr>
		<tr>
			<td   style="padding-left:50px"><h1><span class="dark_blue">Confirm Password *</span></h1></td>
			<td><input  tabindex="10" type="password"  id="confirmpassword" name="confirmpassword" class="text"  style="width:50%" required/></td>
		</tr>
		
		<tr height="50px">
			<td></td>
			<td><input type="submit"  value="Register Now"  tabindex="11" class="button" id="submit" name="submit">
			<span style="font-size:14px;margin-left:10px">Already registered ! Click <a href="login.jsp" tabindex="12" style="color:#116c64;font-weight:bold" >Here</a> to Login</span></td>
		</tr>
		</table>
		</form>
		</td></tr>
		</table>

<%@include file="footer.jsp" %>