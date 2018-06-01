
<%
	request.getSession().setAttribute("selectPage",1);
%>

<%@include file="header.jsp" %>

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
					<div class="title_icon"><img src="../images/mini_icon1.gif" alt="" title="" /></div>
					<h2>User <span class="dark_blue">This is Server Home Page</span></h2>
				</div>
				
				<div class="box_text_content" >
					<table width="100%" cellpadding="0" cellspacing="5" >
						<% %>
					</table>
				</div>
				
				
			</div>
		</td>
		
		
		
	</tr>
</table>

<%@include file="footer.jsp" %>