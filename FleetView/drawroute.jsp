<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>
<%@ include file="Connections/conn.jsp" %>
<%!
Connection conn;
Statement st,st1;
String sql,result,user1;
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
	sql="select Lat, Lat+0.0001 as lat1, Lon,Lon+0.0001 as lon1 from way where OwnerName='"+user1+"' and RouteId='1'";

ResultSet rst=st.executeQuery(sql);
if(rst.next())
{
	lat  = rst.getDouble("Lat");
	lon  = rst.getDouble("Lon");
}
while(rst.next())
{
	lat1 = rst.getDouble("lat"); 
	lon1 = rst.getDouble("lon"); 
		if(null==result)
		{
		result=lat+"#*"+lon+"#*"+lat1+"#*"+lon1;
		}
		else
		{
		result=result+"$"+lat+"#*"+lon+"#*"+lat1+"#*"+lon1;
		}
	lat  = rst.getDouble("lat1");
	lon  = rst.getDouble("lon1"); 

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

