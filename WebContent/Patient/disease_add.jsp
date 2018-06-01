<%@page import="com.java.database.DatabaseConnection" %>
<%@page import="java.sql.ResultSet"%>
<%@include file="header.jsp" %>   
<script type="text/javascript" language="JavaScript">
  
function init()
{
	document.getElementById('name').focus();
}  
window.onload = init;

function validate()
{
	var valid = false;
	var symptoms = trim(document.getElementById('symptoms').value);
	if(symptoms == "" )
	{
		alert("Required - Please provide Symptoms");
		document.getElementById("symptoms").focus();
	}
	else
	{
		valid = true;
	}
	return valid;
} 
</script>   
<script type="text/javascript">
	function getsym(str)
		{
			if (str=="")
			{
				document.getElementById("sym").innerHTML="";
				return;
			} 
			if (window.XMLHttpRequest)
			{// code for IE7+, Firefox, Chrome, Opera, Safari
				xmlhttp=new XMLHttpRequest();
			}
			else
			{// code for IE6, IE5
				xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
			}
			xmlhttp.onreadystatechange=function()
			{
				if (xmlhttp.readyState==4 && xmlhttp.status==200)
				{
					document.getElementById("sym").innerHTML=xmlhttp.responseText;
				}
			}
		xmlhttp.open("GET","getsym.jsp?dis="+str,true);
		xmlhttp.send();
		}
	
	function getspe()
	{
		var str=document.getElementById("disname").value
		var sym=document.getElementById("sym").value
		if (str=="")
		{
			document.getElementById("spedata").innerHTML="";
			return;
		} 
		if (window.XMLHttpRequest)
		{// code for IE7+, Firefox, Chrome, Opera, Safari
			xmlhttp=new XMLHttpRequest();
		}
		else
		{// code for IE6, IE5
			xmlhttp=new ActiveXObject("Microsoft.XMLHTTP");
		}
		xmlhttp.onreadystatechange=function()
		{
			if (xmlhttp.readyState==4 && xmlhttp.status==200)
			{
				document.getElementById("spedata").innerHTML=xmlhttp.responseText;
			}
		}
	xmlhttp.open("GET","getspe.jsp?did="+str+"&sym="+sym,true);
	xmlhttp.send();
	}
</script> 
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
								<a href="index.jsp" class="side_link">Current Disease</a>
							</td>
						</tr>
						<tr>
							<td>
								<a href="javascript:void();" class="side_link active">Add New Disease</a>
							</td>
						</tr>
					</table>
				</td>
				<td>
					<div class="box_content1">
						<div class="box_title">
							<div class="title_icon"><img src="../images/mini_icon1.gif" alt="" title="" /></div>
							<h2>New <span class="dark_blue">Diseases</span></h2>
						</div>
                    
						<div class="box_text_content">
							<form name="send_form"  onsubmit="return validate();" method="post" action="../add_disease" >
							<table width="97%" style="padding-top:10px;border:1px solid #116c64; border-radius:16px;">
							<tr>
								<td  width="120px" style="padding-left:20px"><h1><span class="dark_blue">Disease Name </span></h1></td>
								<td>
									<select name="disname" id="disname" tabindex="1" onchange="getsym(this.value)" style="padding:8px 10px">
										<option value="">-----Select Disease Name-----</option>
										<% 
											DatabaseConnection db = new DatabaseConnection();
											db.dbconnection();
											
											String sql="Select * From dis";
											ResultSet rs=db.getResultSet(sql);
											while(rs.next())
											{
												String diseases=rs.getString("diseases");
												String id=rs.getString("id");
										%>
											<option value="<%=id%>"><%=diseases %></option>
										<% 
											}
										%>
									</select>
								</td>
							</tr>
							<tr>
								<td   style="padding-left:20px;vertical-align:top"><h1><span class="dark_blue">Symptoms *</span></h1></td>
								<td>
									<select name="sym" id="sym" tabindex="1" onchange="getspe()" style="padding:8px 10px">
										<option value="">-----Select Symptoms Name-----</option>
									</select>
								</td>
							</tr>
							<tr>
								<td   style="padding-left:20px;vertical-align:top"><h1><span class="dark_blue">Specialist*</span></h1></td>
							
								<td colspan="2">
									<!--<select name="spe" id="spe" tabindex="1">
										<option value="">-----Select Specialist Name-----</option>
									</select>-->
									<div id="spedata">
									</div>
								</td>
							</tr>
							<tr height="50px">
								<td></td>
								<td><input type="submit"  value="Add Now"  tabindex="11" class="button" id="submit" name="submit">
								<!-- <input type="button"  onclick="loadPage('index.php');" value="Back"  tabindex="12" class="button" id="cancel" name="cancel">-->
								</td>
							</tr>
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