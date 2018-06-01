<%@page import="com.java.database.DatabaseConnection" %>
<%@page import="java.sql.ResultSet"%>
<option value="">-----Select Symptoms Name-----</option>
<%
DatabaseConnection db = new DatabaseConnection();
db.dbconnection();
	
String disid=request.getParameter("dis");

	String sql1 = "Select * From sym Where did='"+disid+"'";
	ResultSet rs1 = db.getResultSet(sql1);
	while (rs1.next()) {
		String symname = rs1.getString("sym");
		String id = rs1.getString("id");
%>
	<option value="<%=id%>"><%=symname %></option>
<%
	}
%>