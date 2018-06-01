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
					</table>
				</td>
				<td>
					<div class="box_content1">
						<div class="box_title">
							<div class="title_icon"><img src="../images/mini_icon1.gif" alt="" title="" /></div>
							<h2>My <span class="dark_blue">Current Diseases</span></h2>
						</div>
                    
						<div class="box_text_content" >
								<form action="../saverate" method="post">
											<table width="100%" cellpadding="0" cellspacing="5" >
											
										<%										
										DatabaseConnection db = new DatabaseConnection();
										db.dbconnection();
												
												String keyname=(String)session.getAttribute("keyname");
												String history_id=(String)session.getAttribute("history_id");
												
												String sql2="Select * from tbl_diagnosis where history_id='"+history_id+"'";
												ResultSet rs2=db.getResultSet(sql2);
												while(rs2.next())
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
													
													request_date=AES.decrypt(request_date,didkey);
													diagnosis=AES.decrypt(diagnosis,didkey);
													hospitalised=AES.decrypt(hospitalised,didkey);
													amt=AES.decrypt(amt,didkey);
													hospital_name=AES.decrypt(hospital_name,didkey);
													
													String sql3="Select * from doctor where user_id='"+doctor_id+"'";
													ResultSet rs3=db.getResultSet(sql3);
													while(rs3.next())
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
																	<b><span class="dark_blue">Total Diagnose Amt </span></b><span class="colon">:</span></td>
																	<td ><%=amt %></td>
																</tr>
																<tr>
																<td>
																		
																			<input type="hidden" id="did" name="did" value="<%=doctor_id%>"/>
																			<input type="hidden" id="history_id" name="history_id" value="<%=history_id%>"/>
																			<div id="dv1"> 
															                    <h1 >Give Rating For Doctor Service:</h1>
															                    <fieldset id='demo3' class="rating">
															                        <input class="stars" type="radio" id="star53" name="rating" value="5" />
															                        <label class = "full" for="star53" title="Awesome - 5 stars"></label>
															                        <input class="stars" type="radio" id="star4half3" name="rating" value="4.5" />
															                        <label class="half" for="star4half3" title="Pretty good - 4.5 stars"></label>
															                        <input class="stars" type="radio" id="star43" name="rating" value="4" />
															                        <label class = "full" for="star43" title="Pretty good - 4 stars"></label>
															                        <input class="stars" type="radio" id="star3half3" name="rating" value="3.5" />
															                        <label class="half" for="star3half3" title="Meh - 3.5 stars"></label>
															                        <input class="stars" type="radio" id="star33" name="rating" value="3" />
															                        <label class = "full" for="star33" title="Meh - 3 stars"></label>
															                        <input class="stars" type="radio" id="star2half3" name="rating" value="2.5" />
															                        <label class="half" for="star2half3" title="Kinda bad - 2.5 stars"></label>
															                        <input class="stars" type="radio" id="star23" name="rating" value="2" />
															                        <label class = "full" for="star23" title="Kinda bad - 2 stars"></label>
															                        <input class="stars" type="radio" id="star1half3" name="rating" value="1.5" />
															                        <label class="half" for="star1half3" title="Meh - 1.5 stars"></label>
															                        <input class="stars" type="radio" id="star13" name="rating" value="1" />
															                        <label class = "full" for="star13" title="Sucks big time - 1 star"></label>
															                        <input class="stars" type="radio" id="starhalf3" name="rating" value="0.5" />
															                        <label class="half" for="starhalf3" title="Sucks big time - 0.5 stars"></label>
															                    </fieldset>
															                    <div id='feedback'></div>
																				<div style='clear:both;'></div>
															                </div>
																		
																	</td>
																	<td>
																	<input type="submit" value="Save Rating"  style="float:right;padding-right:20px;color:blue;font-size:25px" class="button"/>
																	</td>
																</tr>
																<tr><td style="padding:0px 10px" colspan="2"><hr /></td></tr>
															</table>
														</td>
												</tr>
										<%
													}
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