<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Reliable Re-Encryption</title>
<link rel="stylesheet" type="text/css" href="style.css" media="screen" />

</head>
<%@include file="js.jsp" %>


<%
	int select =0;
	if(request.getSession().getAttribute("selectPage")!=null)
		 select = Integer.parseInt(request.getSession().getAttribute("selectPage").toString());
%>


<body>
	<div id="main_container">
		<div class="header">
			<div id="logo"><img src="images/logo.png" alt="" style="float:left" title="R3"  border="0" /><h2 style="FONT-SIZE:30PX">Health System</h2>  <h3 >&nbsp;&nbsp;&nbsp;&nbsp;</h3></div>
			<div class="right_header">
				<div class="top_menu">
					<a <% if(select==5) out.println("class='login current1'"); else out.println("class='login'"); %> class="login" href="login.jsp" class="">login</a>
            		<a <% if(select==6) out.println("class='sign_up current1'"); else out.println("class='sign_up'"); %> class="sign_up" href="sign_up_init.jsp" class="">signup</a>
				</div>
				
				<div id="menu">
                	<ul>                                              
                    	<li><a <% if(select==1) out.println("class='current'"); %> href="index.jsp" title="">Home</a></li>
                    	<li><a <% if(select==2) out.println("class='current'"); %> href="aboutus.jsp" title="">About Us</a></li>
                    	<li><a <% if(select==3) out.println("class='current'"); %> href="service.jsp" title="">Services</a></li>
                    	<li><a <% if(select==4) out.println("class='current'"); %> href="contactus.jsp" title="">Contact Us</a></li>
                	</ul>
            	</div>
			</div>
		</div>
		
		
		<table width="100%" cellpadding="0" class="middle_box_ext" cellspacing="0">
			<tr>
				<td  class="middle_box_content" > <h1>Scalable and Privacy Preserving prediction for<br> Health System</h1></td>
				<td align="right"><img src="images/middle_banner1.gif" height="138px" /></td>
				<td width="200px" class="middle_box_end"></td>
			</tr>
		</table>
		