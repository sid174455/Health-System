
<%@page import="com.java.model.Server"%>
<%@page import="java.util.ArrayList"%>

<%
	request.getSession().setAttribute("selectPage",2);
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
					<h2>All <span class="dark_blue">Server Details</span></h2>
				</div>
				
				<div class="box_text_content" >
					<table width="100%" cellpadding="0" cellspacing="5" >
					
						<% 
							ArrayList<Object> details = new ArrayList<Object>();
							Server server = new Server();
							details = server.getAllServerDetails();
								
							if(details.size() > 0)
								{
								%>
								<tr>
								<td width="50px" style="padding-left:200px"><h1><span class="dark_blue">Server Name</span></h1></td>
								<td width="150px" style="padding-right:100px"><h1><span class="dark_blue">Server Storage</span></h1></td>
								</tr>
									
									<%
									for(int i=0;i<details.size();i++) 
									{ 
										ArrayList list = (ArrayList)details.get(i);
									%>
										<tr><td><br/></td></tr>
										<tr>
											<td style="padding-left:200px"><h2><span class="dark_blue"><%=list.get(1) %></span></h2></td>
											<td ><h2><span class="dark_blue">
											<a href="showServerFile.jsp?id=<%=list.get(0)%>" class="details">Show Storage File</a>
										 
											</span></h2></td>
										</tr>
										
									<%} } else { %>
									<tr>
										<td width="20px" ><img src="../images/calendar.gif" alt="" title="" class="box_icon" />
										<span style="position:absolute;margin-top:10px;margin-left:-27px"></span></td>
										<td style="font-size:16px;color:red"><u><i>No Server available !</i></u></td>
									</tr>
								<% } %>
					</table>
				</div>
				
				
			</div>
		</td>
		
		
		
	</tr>
</table>

<%@include file="footer.jsp" %>