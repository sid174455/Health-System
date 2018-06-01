<%@include file="header.jsp" %>	
<%@page import="com.java.database.DatabaseConnection"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="AES.AES"%>
<!DOCTYPE html>
<html>
<head>     
       <meta content="text/html; charset=UTF-8" http-equiv="Content-Type">
       
        <title>Rating</title>
        <style type="text/css">
        .main { 
                width: 900px; 
                margin: 0 auto; 
                height: 700px;
                border: 1px solid #ccc;
                padding: 20px;
            }

            .header{
                height: 100px;    
            }
            .content{    
                height: 700px;
                border-top: 1px solid #ccc;
                padding-top: 15px;
            }
            .footer{
                height: 100px;  
                bottom: 0px;
            }
            .heading{
                color: #FF5B5B;
                margin: 10px 0;
                padding: 10px 0;
                font-family: trebuchet ms;
            }

            #dv1, #dv0{
                width: 208px;
                border: 1px #ccc solid;
                padding: 15px;
                margin: 10px 10px;
				background-color:black;
            }
           
            /*downloaded from http://devzone.co.in*/
        </style>
        <style>
            /****** Rating Starts *****/
            @import url(http://netdna.bootstrapcdn.com/font-awesome/3.2.1/css/font-awesome.css);

            fieldset, label { margin: 0; padding: 0; }
            body{ margin: 20px; color:black}
            h1 { font-size: 1.5em; margin: 10px; }

            .rating { 
                border: none;
                float: left;
            }

            .rating > input { display: none; } 
            .rating > label:before { 
                margin: 5px;
                font-size: 1.25em;
                font-family: FontAwesome;
                display: inline-block;
                content: "\f005";
            }

            .rating > .half:before { 
                content: "\f089";
                position: absolute;
            }

            .rating > label { 
                color: #ddd; 
                float: right; 
            }

            .rating > input:checked ~ label, 
            .rating:not(:checked) > label:hover,  
            .rating:not(:checked) > label:hover ~ label { color: #FFD700; }

            .rating > input:checked + label:hover, 
            .rating > input:checked ~ label:hover,
            .rating > label:hover ~ input:checked ~ label, 
            .rating > input:checked ~ label:hover ~ label { color: #FFED85;  }     
        </style>
        <script src="../css/jquery.min.js"></script>
         		<script>
                        $(document).ready(function () {
                            $("#demo3 .stars").click(function () {

                                var label = $("label[for='" + $(this).attr('id') + "']");
                                alert($(this).val());
                                $("#feedback").text(input.attr('value'));
                                $(this).attr("checked");
                            });
                        });
        		</script>
</head>
		<%
			if(request.getAttribute("message")!=null)
			{
		%>
		<script type="text/javascript" language="JavaScript">
  			alert("<%=request.getAttribute("message") %>")
		</script>
		<%} %>
       
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
						<tr>
							<td>
								<a href="javascript:void();" class="side_link active">Current Disease</a>
							</td>
						</tr>
						<tr>
							<td>
								<a href="disease_add.jsp" class="side_link">Add New Disease</a>
							</td>
						</tr>
					</table>
				</td>
				<td>
					<div class="box_content1">
						<div class="box_title">
							<div class="title_icon"><img src="../images/mini_icon1.gif" alt="" title="" /></div>
							<h2>My <span class="dark_blue">Current Diseases</span></h2>
						</div>
                    
						<div class="box_text_content" >
								<form action="../addhistory" method="post">
											<table width="100%" cellpadding="0" cellspacing="5" >
											
										<%
										String id=(String)session.getAttribute("uid");
										String keyname=(String)session.getAttribute("keyname");
										DatabaseConnection db = new DatabaseConnection();
										db.dbconnection();
										
										String sql="Select * from tbl_history where user_id='"+id+"'";
										ResultSet rs=db.getResultSet(sql);
										if(rs.next())
										{
											String sql1="Select * from tbl_history where user_id='"+id+"'";
											ResultSet rs1=db.getResultSet(sql1);
											while(rs1.next())
											{
												String history_id=rs1.getString("history_id");
												String did=rs1.getString("doctor_id");
												
												  String pen="P";
												  //pen=AES.encrypt(pen,didkey);
												  //System.out.println(pen);
												
												String sql2="Select * from tbl_diagnosis where history_id='"+history_id+"' and doctor_id='"+did+"' and status='"+pen+"'";
												ResultSet rs2=db.getResultSet(sql2);
												if(rs2.next())
												{
													String doctor_id=rs2.getString("doctor_id");
													String request_date=rs2.getString("request_date");
													String diagnosis=rs2.getString("diagnosis");
													String hospitalised=rs2.getString("hospitalised");
													String hospital_name=rs2.getString("hospital_name");
													String amt=rs2.getString("amt");
													String status=rs2.getString("status");
													
													String ssql1="Select * from doctor where user_id='"+doctor_id+"'";
													ResultSet rss1=db.getResultSet(ssql1);
													rss1.next();
													String didkey=rss1.getString("user_key");
													didkey=AES.decrypt_use(didkey);
													System.out.println(didkey);
													
													request_date=AES.decrypt(request_date,didkey);
													diagnosis=AES.decrypt(diagnosis,didkey);
													hospitalised=AES.decrypt(hospitalised,didkey);
													amt=AES.decrypt(amt,didkey);
													hospital_name=AES.decrypt(hospital_name,didkey);
													
													String sql3="Select * from doctor where user_id='"+doctor_id+"'";
													ResultSet rs3=db.getResultSet(sql3);
													if(rs3.next())
													{
														String dr_name=rs3.getString("user_name");
														dr_name=AES.decrypt(dr_name,didkey);
										%>
											
												<tr>
														<td colspan="2">
															<table width="95%" style="padding-top:10px;border:1px solid #116c64; border-radius:16px;">
																<tr>
																	<td  width="150px" style="padding-left:20px">
																	<b><span class="dark_blue">Doctor Name </span></b><span class="colon">:</span></td>
																	<td ><%=dr_name %></td>
																</tr>
																<tr>
																	<td  width="150px" style="padding-left:20px">
																	<b><span class="dark_blue">Date </span></b><span class="colon">:</span></td>
																	<td ><%=request_date %></td>
																</tr>
																<tr>
																	<td  width="150px" style="padding-left:20px">
																	<b><span class="dark_blue">Diagnos Prescription </span></b><span class="colon">:</span></td>
																	<td ><%=diagnosis %></td>
																</tr>
																<tr>
																	<td  width="150px" style="padding-left:20px">
																	<b><span class="dark_blue">Hospitalise in </span></b><span class="colon">:</span></td>
																	<td ><%=hospitalised %></td>
																</tr>
																<%
																	if(hospitalised.equalsIgnoreCase("YES"))
																	{
																%>
																<tr>
																	<td  width="150px" style="padding-left:20px">
																	<b><span class="dark_blue">Hospital Name</span></b><span class="colon">:</span></td>
																	<td ><%=hospital_name %></td>
																</tr>
																<%
																	}
																%>
																<tr>
																	<td  width="150px" style="padding-left:20px">
																	<b><span class="dark_blue">Total Diagnose Amt </span></b><span class="colon">:</span></td>
																	<td ><%=amt %></td>
																</tr>
																<tr>
																<td>
																<%
																	if(status.equalsIgnoreCase("P"))
																	{
																%>	
																		<input type="hidden" id="history_id" name="history_id" value="<%=history_id%>"/>
																	</td>
																	<td>
																		<a href="../addhistory?history_id=<%=history_id%>" style="float:right;padding-right:20px;color:blue;font-size:25px" class="button">Cure Me Now</a>
																	</td>
																<%
																	}
																	else
																	{
																%>
																	<td><span style="float:right;padding-right:20px;color:green;font-size:25px">Accepted</span></td>
																<%
																	}
																%>
																</tr>
																<tr><td style="padding:0px 10px" colspan="2"><hr /></td></tr>
															</table>
														</td>
												</tr>
										<%
													}
												}
											}
										}
										else
										{
										%>
												<tr>
													<td  ></td>
													<td style="font-size:16px;color:red"><u><i>No Diagnosis Review yet !</i></u></td><td></td>
												</tr>
										<%
										}
										%>
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