
<%
	request.getSession().setAttribute("selectPage",4);
%>

<%@include file="header.jsp" %>

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
						<img width="150px" style="margin:10px -10px 10px 10px;border:1px solid #89D7FD" src="../images/admin_icon.png"  />
					</td>
				</tr>
			</table>
		</td>
		
		<td>
			<div class="box_content1">
				<div class="box_title">
					<div class="title_icon"><img src="../images/my_profile.png" width="50px" alt="" title="" /></div>
					<h2 style="margin-top:10px">My <span class="dark_blue">Profile Details</span></h2>
				</div>
				
				<div class="box_text_content">
					<table width="90%" style="padding-top:10px;border:1px solid #116c64; border-radius:16px;">
						<tr>
							<td  width="140px" style="padding-left:50px"><h1><span class="dark_blue">Full Name :</span></h1></td>
							<td ><%=session.getAttribute("user_name") %></td>
						</tr>
						<tr>
							<td   style="padding-left:50px;vertical-align:top"><h1><span class="dark_blue">Address :</span></h1></td>
							<td><%=session.getAttribute("address") %></td>
						</tr>
						<tr>
							<td   style="padding-left:50px"><h1><span class="dark_blue">Gender :</span></h1></td>
							<td><%=session.getAttribute("gender") %></td>
						</tr>
						<tr>
							<td   style="padding-left:50px"><h1><span class="dark_blue">Age :</span></h1></td>
							<td><%=session.getAttribute("age") %> yrs</td>
						</tr>
						<tr>
							<td   style="padding-left:50px"><h1><span class="dark_blue">Email ID</span></h1></td>
							<td><%=session.getAttribute("email") %></td>
						</tr>
						<tr>
							<td   style="padding-left:50px"><h1><span class="dark_blue">Mobile No :</span></h1></td>
							<td><%=session.getAttribute("mobile") %></td>
						</tr>
						<tr height="50px">
							<td></td>
							<td><input  type="button"  onclick="loadPage('profileEdit.jsp');"   value="Change Profile"  tabindex="11" class="button" id="submit" name="submit">
							<input type="button"  onclick="loadPage('index.jsp');" value="Back"  tabindex="12" class="button" id="cancel" name="cancel">
							</td>
						</tr>
					</table>
				</div>
			</div>
		</td>
	</tr>
</table>

<%@include file="footer.jsp" %>