<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>
<%@ include file="Connections/conn.jsp" %>
<%!
Connection conn;
Statement st,st1;
String sql,result,user1,ColorCode,ColorCode1;
double lat,lon,lat1,lon1;
%>
<%
try{
	result=null;
	user1=session.getAttribute("usertypevalue").toString();
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st = conn.createStatement();
	st1 = conn.createStatement();
	sql = "SELECT LatPosition,LatPosition+0.001 as lat1,LonPosition,LonPosition+0.001 as lon1,ZoneDesc  FROM t_routewaypoints where routeid ='5' order by routeid,wpno";
	
	ResultSet rst = st.executeQuery(sql);
	if(rst.next())
	{
	lat = rst.getDouble("LatPosition"); 
	lon = rst.getDouble("LonPosition"); 
	}
	while(rst.next())
	{
	lat1=rst.getDouble("LatPosition"); 
	lon1=rst.getDouble("LonPosition"); 
 	ColorCode=rst.getString("ZoneDesc");
	if(ColorCode.equals("Green"))
	 ColorCode1="006600";
	if(ColorCode.equals("Red"))
	 ColorCode1="CC0033";
	if(ColorCode.equals("Yellow"))
	 ColorCode1="FFFF00";
	if(ColorCode.equals("Black"))
	 ColorCode1="000000";

		if(null==result)
		{
		result=lat+"#*"+lon+"#*"+lat1+"#*"+lon1+"#*"+ColorCode1;
		}
		else
		{
		result=result+"$"+lat+"#*"+lon+"#*"+lat1+"#*"+lon1+"#*"+ColorCode1;
		}


	lat=rst.getDouble("lat1");
	lon=rst.getDouble("lon1");
}
out.print(result);
}catch(Exception e)
{
	out.print("Exception"+e);
}
finally
{
conn.close();
}
%>

