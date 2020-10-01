<%@ page contentType="text/html; charset=iso-8859-1" language="java" import="java.sql.*" import="java.util.*" import=" java.text.*" errorPage="" %>
<%@ include file="Connections/conn.jsp" %>
<%!
Connection conn;
Statement st,st1;
String sql,result,LatitudePosition,LongitudePosition,user1,name,discription;
%>
<%
try{
	result=null;
	user1=session.getAttribute("usertypevalue").toString();
	Class.forName(MM_dbConn_DRIVER);
	conn = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st = conn.createStatement();
	st1 = conn.createStatement();
	sql="select * from t_waypoints where OwnerName='"+user1+"'";
	ResultSet rst=st.executeQuery(sql);
	while(rst.next())
	{
	LatitudePosition=rst.getString("Lon");
	LongitudePosition=rst.getString("Lat");
	name=rst.getString("Name");
	discription=rst.getString("Discription");
	if(null==result)
		{
		result=LatitudePosition+"#*"+LongitudePosition+"#*"+name;
		}
		else
		{
			result=result+"$"+LatitudePosition+"#*"+LongitudePosition+"#*"+name;
		}
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

