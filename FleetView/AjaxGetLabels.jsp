<%@page import="org.apache.poi.hssf.record.formula.functions.Replace"%><%@ include file="Connections/conn.jsp" %>

<%!
Connection con1;
Statement st;
%>
<% 
try {
	Class.forName(MM_dbConn_DRIVER);
	con1 = DriverManager.getConnection(MM_dbConn_STRING,MM_dbConn_USERNAME,MM_dbConn_PASSWORD);
	st=con1.createStatement();
	
	
	String html="";

	
	String sql = "select * from db_gps.t_citynames where Category = 'District'";
	ResultSet rs=st.executeQuery(sql);
	//System.out.println("^^^^^^    "+sql);
	while(rs.next())
	{
			
		html +=rs.getDouble("Latitude")+","+rs.getDouble("Longitude")+","+rs.getString("Name")+","+rs.getInt("Sales")+"$";
			
	}
	
	//System.out.println(html);
	out.println(html);
	
}catch(Exception e)
{
	e.printStackTrace();
}
finally
	{
		st.close();
		con1.close();
	}
	%>