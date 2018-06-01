
<%
	request.getSession().setAttribute("selectPage",3);
%>

<%@include file="header.jsp" %>

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
	document.getElementById('servername').focus();
}  
window.onload = init;


function validate()
{
	
	var valid = false;
	
	var servername = document.getElementById('servername').value;
		
	if(servername == "" )
	{
		alert("Required - Please provide Server Name");
		document.getElementById("servername").focus();
	}
	else
	{
		valid = true;
	}
	return valid;
} 


</script>

<table width="100%" cellpadding="0" cellspacing="10">
	<tr style="vertical-align:top">
		<td width="100px" >
			<table width="100%" class="box_content2" cellpadding="0" cellspacing="5">
				<tr>
					<td >
						<img width="150px" style="margin:10px -10px 10px 10px;border:1px solid #89D7FD" src="../images/admin_icon.png"  />
					</td>
				</tr>
			</table>
		</td>
		
		<td>
			<div class="box_content1">
				<div class="box_title">
					<div class="title_icon"><img src="../images/system-icon.png" width="50px" alt="" title="" /></div>
					<h2 style="margin-top:10px">Create <span class="dark_blue">New Server</span></h2>
				</div>
				
				<div class="box_text_content">
				<form name="serverForm" onsubmit="return validate();" method="post" action="CreateNewServerServlet" >
					<table width="90%" style="padding-top:10px;border:1px solid #116c64; border-radius:16px;">
						<tr>
						<td><br/><br/><br/><br/></td>							
						</tr>
						
						<tr>
							<td  width="140px" style="padding-left:50px"><h1><span class="dark_blue">Server Name :</span></h1></td>
							<td ><input autocomplete="off" tabindex="1"  type="text"  id="servername" name="servername" size="60" /></td>
						</tr>
						
						<tr height="50px">
							<td></td>
							<td><input  type="submit" value="Create New Server" class="button" id="submit" name="submit">
							<input type="button"  onclick="loadPage('index.jsp');" value="Back"  tabindex="12" class="button" id="cancel" name="cancel">
							</td>
						</tr>
						
						<tr>
						<td><br/></td>							
						</tr>
						
					</table>
					</form>
				</div>
			</div>
		</td>
	</tr>
</table>

<%@include file="footer.jsp" %>