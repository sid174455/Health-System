<%@page import="com.java.model.Server"%>
<%@page import="com.java.model.FileManagement"%>
<%@page import="java.util.ArrayList"%>
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
		
		<%
			int serverId = Integer.parseInt(request.getParameter("id"));
			Server server = new Server();
			String serverName = server.getServerName(serverId);
		%>
		
		<td>
			<div class="box_content1">
				<div class="box_title">
					<div class="title_icon"><img src="../images/mini_icon1.gif" alt="" title="" /></div>
					<h2>All <span class="dark_blue">File Details of </span><%=serverName %></h2>
				</div>
				
				<div class="box_text_content" >
					<table width="100%" cellpadding="0" cellspacing="5" >
					
						<% 
								
								ArrayList<Object> details = new ArrayList<Object>();
								FileManagement fm = new FileManagement();
								details = fm.getAllServerFileDetails(serverId);
								
								if(details.size() > 0)
								{
								%>
									<tr>
									<td width="100px" style="padding-left:20px"><h1><span class="dark_blue">FileName</span></h1></td>
									<td width="100px" ><h1><span class="dark_blue">Upload Date</span></h1></td>
									<td width="100px" ><h1><span class="dark_blue">Time Slice</span></h1></td>
									<td width="100px" ><h1><span class="dark_blue">Time Slot</span></h1></td>
									<td width="120px" ><h1><span class="dark_blue">Expiry Date</span></h1></td>
									</tr>
									
									<%
									for(int i=0;i<details.size();i++) 
									{ 
										ArrayList list = (ArrayList)details.get(i);
									%>
										
										<tr>
											<td style="padding-left:10px"><h4><span class="dark_blue"><%=list.get(0) %></span></h4></td>
											<td style="padding-left:10px"><h4><span class="dark_blue"><%=list.get(1) %></span></h4> </td>
											<td style="padding-left:35px"><h4><span class="dark_blue"><%=list.get(2) %></span></h4> </td>
											<td style="padding-left:20px"><h4><span class="dark_blue"><%=list.get(3) %></span></h4> </td>
											<td style="padding-left:10px"><h4><span class="dark_blue"><%=list.get(4) %></span></h4> </td>
											
										</tr>
									<%} } else { %>
									<tr>
										<td width="20px" ><img src="../images/calendar.gif" alt="" title="" class="box_icon" />
										<span style="position:absolute;margin-top:10px;margin-left:-27px"></span></td>
										<td style="font-size:16px;color:red"><u><i>No File Details available !</i></u></td>
									</tr>
								<% } %>
					</table>
				</div>
				
				
			</div>
		</td>
		
		
		
	</tr>
</table>

<%@include file="footer.jsp" %>