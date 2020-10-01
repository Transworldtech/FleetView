<%@ include file="headernew.jsp" %>
<html>
<%!
Connection conn;
%>
<%
String dd=request.getQueryString();
if(dd==null)
{
}
else
{
	String city, lat, lon, imgname, name, discription, user;
	lat=request.getParameter("lon");
	lon=request.getParameter("lat");
	name=request.getParameter("name");
	discription=request.getParameter("discription");
	user=session.getAttribute("usertypevalue").toString();
try{
	
	
	 Class.forName(MM_dbConn_DRIVER);
	 conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	Statement st=conn.createStatement();
	Statement stquery=conn.createStatement();
	String sql2="insert into t_waypoints (Name, Lat, Lon, Discription, OwnerName) values('"+name+"','"+lat+"','"+lon+"','"+discription+"','"+user+"')";
	
	/*Query to insert query in db_gps.t_sqlquery table*/
	String abcd=sql2.replace("'","#");
	abcd=abcd.replace(",","$");
	stquery.executeUpdate("insert into db_gps.t_sqlquery(dbname,query)values('db_gps','"+abcd+"')");
	/*****************************/
	
	int rst2=st.executeUpdate(sql2);
	if(rst2<=0)
	{
		out.print("Error :Not Inserted");
	}
	else
	{
		response.sendRedirect("waypoint.jsp");
		return;
	}
}catch(Exception e)
{
	out.print("Exception "+e);
}finally
{
	try
	{
		
	}catch(Exception e)
	{
		conn.close();
	}
}
}
%>
</html>
