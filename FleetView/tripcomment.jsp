<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

 <%@ include file="Connections/conn.jsp" %><html>
<head>
<script src="sorttable.js" type="text/javascript"></script>
<link href="css/css.css" rel="StyleSheet" type="text/css"></link>
<link href="css/erratic.css" rel="StyleSheet" type="text/css"></link>
<script src="js/elabel.js" type="text/javascript"></script>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
<%!Connection conn; %>
<% 
String vehcode="", vehreg="", stplace="", endplace="", stdate="", sttime="", driverid="", drivername="", stcode="", endcode="", gpname="",ownername="";

try {



	Class.forName(MM_dbConn_DRIVER);
conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
Statement stmt1=conn.createStatement(), stmt2=conn.createStatement(), stmt3=conn.createStatement(),stmt4=conn.createStatement();
ResultSet rs1=null, rs4=null, rs5=null, rs7=null, rs8=null, rs10=null, rs11=null, rs13=null, rs14=null, rs15=null, rs16=null, rs17=null,rs18=null;
String sql1="", sql2="", sql3="", sql4="", sql5="", sql6="", sql7="", sql8="", sql9="", sql10="", sql11="", sql13="", sql14="", sql15="", sql16="", sql17="",sql18="";
String vehiclecode=request.getParameter("vehcode");
String vehno=request.getParameter("vehno");
String tripid=request.getParameter("tripid");
		


	
	

   	
   	
%>
<table border="0" width="100%"  class="stats">
<tr><td colspan="6" align="center"> <font size="3" color="maroon"> <B>Comment for <%=vehno%> </B> </font> </td></tr>
			<tr>
			<td class="hed" align="center" ><b>Sr.No.</b></td>
			<td class="hed" align="center" ><b>Ent Date Time</b></td>
			<td class="hed" align="center" > <b>TripID</b></td>
			<td class="hed" align="center"> <b> Vehicle</b></td>
			<td class="hed" align="center" > <b>Comment</b> </td>
			<td class="hed" align="center" ><b>Ent By.</b></td>
			</tr>

<%
int i=1;
	String sql12="select * from t_tripcomments where TripId='"+tripid+"' and vehid="+vehiclecode;
	ResultSet rs12=stmt1.executeQuery(sql12);
	while(rs12.next())
	{ %>
	<tr>
				<td><%=i%></td>
				<td><%=rs12.getString("datetime")%></td>
				<td><%=rs12.getString("tripid") %></td>
				<td><%=rs12.getString("vehregno")%></td>
				<td><%=rs12.getString("comment") %></td>
				
				<td><%=rs12.getString("entby")%></td>	
	</tr>
		
<%
i++;
}
}catch(Exception ex)
{
	System.out.print("Exception "+ex);
	}
finally
{
	try
	{
		conn.close();
	}
	catch(Exception e){}
	
}

%>
</table>
</body>
</html>