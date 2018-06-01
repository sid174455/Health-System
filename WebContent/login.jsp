
<%
	request.getSession().setAttribute("selectPage",5);
%>

<%@include file="header_home.jsp" %>

		
		<%
			if(request.getAttribute("message")!=null)
			{
		%>
		<script type="text/javascript" language="JavaScript">
  			alert("<%=request.getAttribute("message") %>")
		</script>
		<%} %>
		
		<script type="text/javascript" language="JavaScript">
  
			function init()
			{
				document.getElementById('username').focus();
			}  
			window.onload = init;
			function validate(str)
			{
				var valid = false;
				var username = trim(document.getElementById('username').value);
				var password = trim(document.getElementById('password').value);
				if(username == "" )
				{
					alert("Required - Please provide Username");
				}
				else if(password == "" )
				{
					alert("Required - Please provide Password");
				}
				else
				{
					valid = true;
				}
				return valid;
			} 

		</script>
		
		<table  width="100%" height="" >
			<tr><td align="center">
				<table class="pattern_ext1"  border="0" width="500px"  style="padding:10px 30px 30px 30px">
					<tr><td ><h1>Login <span class="blue"> Panel</span></h1></td></tr>
					<tr><td style="border:1px solid #FFF; border-radius:5px;width:100%">
					<form name="loginForm" onsubmit="return validate();" method="post" action="LoginServlet" >
						<table width="100%" cellspacing="10">
							<tr><td width="200px"><img src="images/login.jpg" width="200px" height="150px" class="img"/></td>
							<td><table width="100%" cellspacing="10">
							<tr><td  width="100px" style="padding-left:0px"><h1>Username</h1></td><td><input autocomplete="off" tabindex="1" type="text"  id="username" name="username"></td></tr>
							<tr><td  style="padding-left:0px"><h1>Password</h1></td><td><input type="password"  autocomplete="off"  tabindex="2" id="password" name="password"></td></tr>
							<tr><td></td><td><input type="submit"  value="Login"  tabindex="3" class="button" id="submit" name="submit"></td></tr>
							<tr><td></td><td style="color:#FFF;font-size:14px">Not registered ? <br>Click <a href="signup.jsp" tabindex="4" style="color:#FFF;font-weight:bold" >Here</a> to Register</td></tr>
							</table></td></tr>
						</table>
					</form>
					</td></tr>
				</table>
	 		</td></tr>
	 	</table>
		
		<br/><br/>
		<%@include file="footer.jsp" %>